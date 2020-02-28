#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Weibo : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, assign, getter=isVip) BOOL vip;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)weiboWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
