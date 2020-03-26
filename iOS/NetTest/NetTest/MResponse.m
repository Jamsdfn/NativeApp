//
//  MResponse.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/26.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "MResponse.h"

@implementation MResponse

+ (instancetype)messageWithDictionary:(NSDictionary *)dict{
    MResponse *msg = [self new];
    [msg setValuesForKeysWithDictionary:dict];
    return msg;
}

@end
