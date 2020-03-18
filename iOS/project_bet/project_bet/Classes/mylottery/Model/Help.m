//
//  Help.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/18.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "Help.h"

@implementation Help

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.html = dict[@"html"];
        self.identifier = dict[@"id"];
    }
    return self;
}

+ (instancetype)helpWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
