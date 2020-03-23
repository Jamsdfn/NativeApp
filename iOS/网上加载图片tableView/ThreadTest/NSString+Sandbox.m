//
//  NSString+Sandbox.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/23.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "NSString+Sandbox.h"



@implementation NSString (Sandbox)

- (instancetype)appendCache{
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)appendTmp{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}

- (instancetype)appendDocument{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[self lastPathComponent]];
}


@end
