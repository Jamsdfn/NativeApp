//
//  ViewController.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/20.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "Single.h"
@interface ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *photoList;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSMutableArray *)photoList{
    if (!_photoList) {
        _photoList = [[NSMutableArray alloc] init];
    }
    return _photoList;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self test];
    
}

- (void)test{
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第一首");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第二首");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第三首");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self show];
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"test");
}
- (void)show{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"通知" message:@"已全部下载完成" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
