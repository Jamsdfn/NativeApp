//
//  NavigationController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/15.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
//    NSFontAttributeName
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 设置主题色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
  // 设置状态栏样式（默认，dark，light）
        return UIStatusBarStyleLightContent;
}

// sb用show 重写点击navigation跳转到下一个控制器的方法，让其默认隐藏tabbar
- (void)showViewController:(UIViewController *)vc sender:(id)sender{
    vc.hidesBottomBarWhenPushed = YES;
    [super showViewController:vc sender:sender];
}
// 因为用代码的方式是push，所以push的方法也要重写一下
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
