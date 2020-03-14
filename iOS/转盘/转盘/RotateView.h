//
//  RotateView.h
//  转盘
//
//  Created by Jamsdfn on 2020/3/14.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RotateView;
@protocol RotateViewDelegate <NSObject>
@required
- (void)rotateView:(RotateView *)rotateView alertWithAlertController:(UIAlertController *)alertController;

@end

@interface RotateView : UIView

@property (nonatomic, weak) UIViewController<RotateViewDelegate> *delegate;

+ (instancetype)rotateView;
- (void)startRotate;

@end

