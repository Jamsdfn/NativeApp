//
//  ViewController.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/20.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import "App.h"
#import "AppCell.h"
#import "ViewController.h"
#import "NSString+Sandbox.h"
@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSArray *apps;
@property (nonatomic, strong) NSMutableDictionary *imageCache;
@property (nonatomic, strong) NSMutableDictionary *downloadCache;

@end

@implementation ViewController
// 懒加载
- (NSMutableDictionary *)downloadCache{
    if (!_downloadCache) {
        _downloadCache = [NSMutableDictionary new];
    }
    return _downloadCache;
}
- (NSMutableDictionary *)imageCache{
    if (!_imageCache) {
        _imageCache = [NSMutableDictionary new];
    }
    return _imageCache;
}
- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
- (NSArray *)apps{
    if (!_apps) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *dict in arr) {
            App *model = [App appWithDictionary:dict];
            [arrM addObject:model];
        }
        // 让可变数组转化为不可变数组
        _apps = arrM.copy;
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    App *app = self.apps[indexPath.row];
    AppCell *cell = [AppCell appcellWithTableView:tableView];
    cell.model = app;
    if (self.imageCache[app.icon]) {
        cell.imageView.image = self.imageCache[app.icon];
        return cell;
    }
    // 设置占位图，要放在下载上面，防止复用的时候带上老的icon
    cell.imageView.image = [UIImage imageNamed:@"user_default"];
    // 检查沙盒中是否有图片
    NSData *data = [NSData dataWithContentsOfFile:[app.icon appendCache]];
    if (data) {
        UIImage *icon = [UIImage imageWithData:data];
        // 保存到内存中
        self.imageCache[app.icon] = icon;
        cell.imageView.image = icon;
        return cell;
    }
    // 网上下载
    [self downloadIconWithIndexPath:indexPath];
    return cell;
}

- (void)downloadIconWithIndexPath:(NSIndexPath *)indexPath{
    App *app = self.apps[indexPath.row];
    // 防止重复下载
    if (self.downloadCache[app.icon]) {
        return;
    }
    // 如果过多次经过一段下载特别慢的图，那会发生重复的下载的问题，因此是否下载要判断是否存在对应的下载操作
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:app.icon]];
        UIImage *icon = [UIImage imageWithData:data];
        // 因为是从网上下载的，所以有可能会拿不到图片，要判断一下
        // 不然的话明明没有图片又移除op，然后又刷新cell会进入死循环的
        if (icon) {
            // 把图片写进缓存中
            [data writeToFile:[app.icon appendCache] atomically:YES];
            @synchronized (self) {
                // 下载好就移除op缓存池，这样会防止循环引用的问题
                // 因为op执行完就会被队列移除，这里把自定义的字典中的op也移除，那就不会发生循环引用问题
                [self.downloadCache removeObjectForKey:app.icon];
                self.imageCache[app.icon] = icon;
            }
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // 如果网速太慢，没加载完就滚过了的话，原本复用的cell被之前的cell下载好的图片覆盖掉
            // 因为是异步执行的，cell肯能会迟一点才刷新，导致显示错乱
            // 为了防止错乱显示，要用reload，是哪一行的就下载的图片，就更新哪一行
            //            cell.imageView.image = icon;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }];
    self.downloadCache[app.icon] = op;
    [self.queue addOperation:op];
}

// 如果收到内存警告，则清除图片h缓存池
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [self.imageCache removeAllObjects];
    [self.downloadCache removeAllObjects];
}

@end
