//
//  Help.h
//  project_bet
//
//  Created by Jamsdfn on 2020/3/18.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Help : NSObject


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *html;
@property (nonatomic, copy) NSString *identifier;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)helpWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
