//
//  Tabbar.h
//  project_bet
//
//  Created by Jamsdfn on 2020/3/14.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Tabbar : UIView

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) void (^tabbarBtnBlock)(NSInteger);

- (void)addButtonWithImage:(UIImage *)image addImageSel:(UIImage *)imageSel;

+ (instancetype)tabbar;

@end

NS_ASSUME_NONNULL_END
