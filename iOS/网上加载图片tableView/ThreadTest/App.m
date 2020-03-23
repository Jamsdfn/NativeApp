//
//  App.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/23.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "App.h"

@implementation App
- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

+ (instancetype)appWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
