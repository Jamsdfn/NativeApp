//
//  Single.h
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/21.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Single : NSObject
+ (instancetype)sharedSingle;
+ (instancetype)defaultSingle;
@end

NS_ASSUME_NONNULL_END
