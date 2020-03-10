//
//  UnlockView.h
//  手势解锁
//
//  Created by Jamsdfn on 2020/3/10.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnlockView : UIView

@property (nonatomic, copy) BOOL (^passwordBlock)(NSString *);

@end

NS_ASSUME_NONNULL_END
