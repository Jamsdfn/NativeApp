//
//  TabBarController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/14.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "TabBarController.h"
#import "Tabbar.h"
@interface TabBarController ()


@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置 tabbarController的子控制器
   UIViewController *v1 = [self loadSubViewControllerWithSBName:@"Hall"];
   UIViewController *v2 = [self loadSubViewControllerWithSBName:@"Arena"];
   UIViewController *v3 = [self loadSubViewControllerWithSBName:@"Discovery"];
   UIViewController *v4 = [self loadSubViewControllerWithSBName:@"History"];
   UIViewController *v5 = [self loadSubViewControllerWithSBName:@"MyLottery"];
   self.viewControllers = @[v1,v2,v3,v4,v5];
    
    // 自定义tabbar，直接自定义一个tabbar把系统默认的盖住
    Tabbar *tabbar = [Tabbar tabbar];
    tabbar.count = self.viewControllers.count;
    tabbar.tabbarBtnBlock = ^(NSInteger index) {
        self.selectedIndex = index;
    };
    [self.view addSubview:tabbar];
    // 给tabbar创建按钮
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar%d", i + 1]];
        UIImage *imageSel = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar%dSel", i + 1]];
        [tabbar addButtonWithImage:image addImageSel:imageSel];
    }
}
- (UIViewController *)loadSubViewControllerWithSBName:(NSString*)name{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:name bundle:nil];
    return sb.instantiateInitialViewController;
}


@end
