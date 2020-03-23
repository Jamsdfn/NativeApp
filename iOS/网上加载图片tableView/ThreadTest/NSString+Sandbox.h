//
//  NSString+Sandbox.h
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/23.
//  Copyright © 2020 Alexander. All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Sandbox)

// 把路径文件名，追加到沙盒文件夹的路径后面
- (instancetype)appendCache;
- (instancetype)appendTmp;
- (instancetype)appendDocument;

@end

NS_ASSUME_NONNULL_END
