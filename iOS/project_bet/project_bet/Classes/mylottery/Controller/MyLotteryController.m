//
//  MyLotteryController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/16.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "MyLotteryController.h"
#import "SettingController.h"

@interface MyLotteryController ()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation MyLotteryController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *login = [UIImage imageNamed:@"RedButton"];
    login = [login stretchableImageWithLeftCapWidth:0.5 * login.size.width topCapHeight:0.5 * login.size.height];
    UIImage *loginH = [UIImage imageNamed:@"RedButtonPressed"];
    loginH = [loginH stretchableImageWithLeftCapWidth:0.5 * loginH.size.width topCapHeight:0.5 * loginH.size.height];
    [self.loginBtn setBackgroundImage:login forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:loginH forState:UIControlStateHighlighted];
}
// 跳转到
- (IBAction)settingClick:(id)sender {
    // 跳转到设置
    SettingController *setting = [[SettingController alloc] init];
    setting.navigationItem.title = @"设置";
    [self.navigationController pushViewController:setting animated:YES];
}


@end
