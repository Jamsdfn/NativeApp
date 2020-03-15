//
//  Tabbar.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/14.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "Tabbar.h"


@interface MyBtn : UIButton
    
@end
@implementation MyBtn
- (void)setHighlighted:(BOOL)highlighted{
    // [super setHighlighted:highlighted] 不要这句话就是可以了
}
@end

@interface Tabbar()

@property (nonatomic, weak) UIButton *currentBtn;

@end

@implementation Tabbar


- (void)addButtonWithImage:(UIImage *)image addImageSel:(UIImage *)imageSel{
    MyBtn *tabbarBtn = [[MyBtn alloc] init];
    [tabbarBtn setBackgroundImage:image forState:UIControlStateNormal];
    [tabbarBtn setBackgroundImage:imageSel forState:UIControlStateSelected];
    

    [tabbarBtn addTarget:self action:@selector(tabBarBtnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:tabbarBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *tabbarBtn = self.subviews[i];
        tabbarBtn.tag = i; // 用于对应控制器
        CGFloat w = self.frame.size.width / self.count;
        CGFloat h = self.frame.size.height;
        CGFloat x = i * w;
        CGFloat y = 0;
        tabbarBtn.frame = CGRectMake(x, y, w, h);
        if (i == 0) {
            [self tabBarBtnClick:tabbarBtn];
        }
    }
}

+ (instancetype)tabbar{
    // 适配
    CGFloat scale = KScreenWidth / 320;
    CGFloat w = 320 * scale;
    CGFloat h = 49 * scale;
    CGFloat y = 49 - h;
    CGFloat x = 0;
    return [[self alloc] initWithFrame:CGRectMake(x, y, w, h)];
}



- (void)tabBarBtnClick:(UIButton *)sender{
    self.currentBtn.selected = NO;
    sender.selected = YES;
    self.currentBtn = sender;
    
    // 切换控制器
    if (self.tabbarBtnBlock) {
        self.tabbarBtnBlock(sender.tag);
    }
//    self.selectedIndex = sender.tag;
}

@end
