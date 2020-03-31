//
//  Manager.h
//  NetTest
//
//  Created by Jamsdfn on 2020/3/31.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Manager : NSObject

+ (instancetype)sharedManager;
- (void)download:(NSString*)urlString successBlock:(void(^)(NSString *path))successBlock processBlock:(void(^)(float process))processBlock errorBlock:(void(^)(NSError *error))errorBlock;
- (void)pause:(NSString*)urlString;

@end

NS_ASSUME_NONNULL_END
