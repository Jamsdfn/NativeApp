#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Goods : NSObject

@property (nonatomic, copy) NSString *buyCount;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)goodsWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
