#import "TableViewController.h"
#import "Weibo.h"
#import "WeiboCell.h"
#import "WeiboFrame.h"
@interface TableViewController ()

@property (nonatomic, strong) NSArray *weiboFrames;

@end

@implementation TableViewController


- (NSArray *)weiboFrames{
    if (!_weiboFrames){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for(NSDictionary *item in arr){
            WeiboFrame *frame = [WeiboFrame weiboFrameWithDictionary:item];
            [arrM addObject:frame];
        }
        _weiboFrames = arrM;
    }
    return _weiboFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self weiboFrames];
//    self.tableView.rowHeight = 300;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.weiboFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboFrame *frame = self.weiboFrames[indexPath.row];
    NSString *ID = @"weibo_cell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.weiboFrame = frame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeiboFrame *frame =  self.weiboFrames[indexPath.row];
    return frame.rowHeight;
}

@end
