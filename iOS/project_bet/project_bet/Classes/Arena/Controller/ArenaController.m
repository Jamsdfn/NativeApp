//
//  ArenaController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/15.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ArenaController.h"

@interface ArenaController ()

@end

@implementation ArenaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 默认是拉伸的
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"NLArenaBackground"].CGImage;
    // 设置nav图片，并且拉伸到屏幕的长度
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NLArenaNavBar64"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    // 获取那个二选一的选择器
    UISegmentedControl *segment = (UISegmentedControl*)self.navigationItem.titleView;
    [segment setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    // 如果测试发现两个按钮中间有一根线，可以用下面的方法清除掉
//    [segment setTintColor:[UIColor clearColor]];
}


@end
