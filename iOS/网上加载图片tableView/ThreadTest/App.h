//
//  App.h
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/23.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface App : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *download;
//@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)appWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
