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


@end
