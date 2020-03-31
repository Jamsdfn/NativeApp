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

@property (nonatomic, copy) NSNumber *videoId;
@property (nonatomic, copy) NSString *name;
// 为了防止KVC赋值的时候因为可变字符串的改变而改变
@property (nonatomic, copy) NSNumber *length;
@property (nonatomic, copy) NSString *videoURL;
@property (nonatomic, copy) NSString *imageURL;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *teacher;

@property (nonatomic, readonly) NSString *time;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)messageWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
