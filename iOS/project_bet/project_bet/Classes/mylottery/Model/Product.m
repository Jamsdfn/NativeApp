//
//  Product.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

//"title": "邮箱大师",
//"stitle":"网易推出的通用邮箱APP",
//"id": "com.netease.mailmaster",
//"url": "https://itunes.apple.com/cn/app/you-xiang-da-shi/id897003024?mt=8",
//"icon": "mail",
//"customUrl": "mailmaster"

#import "Product.h"

@implementation Product


- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        // 因为id是oc的关键字，所以不能直接用 [self setValuesForKeysWithDictionary:dict];
        self.title = dict[@"title"];
        self.stitle = dict[@"stitle"];
        self.identifier = dict[@"id"];
        self.url = dict[@"url"];
        self.icon = dict[@"icon"];
        self.customUrl = dict[@"customUrl"];
    }
    return self;
}

+ (instancetype)productWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}


@end
