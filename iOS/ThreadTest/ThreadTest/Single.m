//
//  Single.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/21.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "Single.h"

@implementation Single
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
          instance = [super allocWithZone:zone];
        }
    });
    return instance;
}
+ (instancetype)sharedSingle {
  return [self new];
}
+ (instancetype)defaultSingle {
  return [self new];
}
@end
