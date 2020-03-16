//
//  GroupBtnController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/15.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "GroupBtnController.h"
#import "UIView+Frame.h"
@interface GroupBtnController ()

@property (nonatomic, weak) UIView *blueView;

@end

@implementation GroupBtnController

- (UIView *)blueView{
    if (!_blueView){
        UIView *blueView = [[UIView alloc] init];
        blueView.backgroundColor = [UIColor blueColor];
        blueView.frame = CGRectMake(0, 0, KScreenWidth, 0);
        [self.view addSubview:blueView];
        _blueView = blueView;
    }
    return _blueView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self blueView];
    // navBar设置为不透明
    // 设置之后self.view的坐标轴的y周零点位置就变成了navBar的height
    [self.navigationController.navigationBar setTranslucent:NO];
}
// 按钮点击事件
- (IBAction)groupBtnClick:(UIButton *)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.blueView.h = self.blueView.h ? 0 : 150;
        // 图片旋转
        sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);
    }];
}


@end
