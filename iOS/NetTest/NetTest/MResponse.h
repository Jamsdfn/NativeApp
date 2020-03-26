//
//  MResponse.h
//  NetTest
//
//  Created by Jamsdfn on 2020/3/26.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MResponse : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSNumber *messageId;

+ (instancetype)messageWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
