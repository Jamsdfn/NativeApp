//
//  GroupBtn.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/15.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "GroupBtn.h"
#import "UIView+Frame.h"
@implementation GroupBtn


- (void)layoutSubviews{
    [super layoutSubviews];
    // label 和 img 改位置
//    CGRect labelRect = self.titleLabel.frame;
//    labelRect.origin.x = 0;
//    self.titleLabel.frame = labelRect;
//
//    CGRect imgRect = self.imageView.frame;
//    imgRect.origin.x = labelRect.size.width;
//    self.imageView.frame = imgRect;
    // label 和 img 改位置，这里我是自己写了个类扩展才能这样写，不然老老实实取rect改rect再赋值
    self.titleLabel.x = 0;
    
    self.imageView.x = self.titleLabel.w;
}

@end
