//
//  ViewController.m
//  转盘
//
//  Created by Jamsdfn on 2020/3/14.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "RotateView.h"
@interface ViewController () <RotateViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"LuckyBackground"].CGImage;
    // 添加转盘
    RotateView *rotateView = [RotateView rotateView];
    // 设置转盘的位置
    rotateView.center = self.view.center;
    // 让控制器执行弹出alert框代码
    rotateView.delegate = self;
    // 添加到控制器上
    [self.view addSubview:rotateView];
    [rotateView startRotate];
}

- (void)rotateView:(RotateView *)rotateView alertWithAlertController:(UIAlertController *)alertController{
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
