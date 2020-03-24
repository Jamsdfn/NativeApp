//
//  CustomOperation.h
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/24.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomOperation : NSOperation

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) void (^finishedBlock) (UIImage *);

+ (instancetype)customOperationWithURLString:(NSString*)urlString andFinishedBlock:(void (^)(UIImage *img))finishedBlock;

@end

NS_ASSUME_NONNULL_END
