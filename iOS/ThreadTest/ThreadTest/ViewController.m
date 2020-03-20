//
//  ViewController.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/20.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController

- (void)loadView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.scrollView;
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSThread detachNewThreadWithBlock:^{
        [self demo];
    }];
    NSLog(@"11111");
}
- (void)demo{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.yunwen11.com/big_img/banner.png.1920x500_q85.png"]];
    NSLog(@"%@",data);
    // 只能在主线程中操作UI
    // 最后一个参数YES则表示，等待这个方法执行完才会执行后面的代码。(是否同步操作)
    [self performSelectorOnMainThread:@selector(showImg:) withObject:[UIImage imageWithData:data] waitUntilDone:NO];
    NSLog(@"render finish");
}
- (void)showImg:(UIImage *)image{
    NSLog(@"render start");
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = image.size;
}
// https://iknow-pic.cdn.bcebos.com/d043ad4bd11373f092c78684a60f4bfbfbed0434
@end
