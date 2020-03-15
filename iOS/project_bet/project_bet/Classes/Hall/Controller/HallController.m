//
//  HallController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/15.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "HallController.h"

@interface HallController ()

@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UIImageView *closeImageView;

@end

@implementation HallController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img = [UIImage imageNamed:@"CS50_activity_image"];
    // 因为navigationitem默认是变成蓝色的，为了保持图片不变成蓝色要设置图片的渲染方式
    img  = [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(avtivityClick)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)avtivityClick{
    // 遮罩
    UIView *coverView = [[UIView alloc] initWithFrame:KScreenSize];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    // 添加到最外层的控制器才会全覆盖
    [self.tabBarController.view addSubview:coverView];
    self.coverView = coverView;
    
    // initWithImage 创建好就默认有大小，只要设置位置就好了
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"showActivity"]];
    imageView.center = self.view.center;
    // 因为coverView设置了透明度了，因此不添加在里面
    [self.tabBarController.view addSubview:imageView];
    self.closeImageView = imageView;
    
    // 关闭按钮
    UIButton *closeButton = [[UIButton alloc] init];
    UIImage *closeImg = [UIImage imageNamed:@"alphaClose"];
    closeButton.frame = CGRectMake(imageView.bounds.size.width - closeImg.size.width - 5, 5, closeImg.size.width, closeImg.size.height);
    [closeButton setImage:closeImg forState:UIControlStateNormal];
    [imageView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeActivity) forControlEvents:UIControlEventTouchUpInside];
    self.closeImageView.userInteractionEnabled = YES;
}

- (void)closeActivity{
    // 系统的默认的动画都是0.25秒，模仿一下
    [UIView animateWithDuration:0.25 animations:^{
        [self.coverView removeFromSuperview];
        [self.closeImageView removeFromSuperview];
    }];
    
    
}

@end
