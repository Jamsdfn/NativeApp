#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarGroup : NSObject
// 组标题
@property (nonatomic, copy) NSString *title;
// 组描述
@property (nonatomic, copy) NSString *desc;
// 汽车品牌
@property (nonatomic, strong) NSArray *cars;


- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)carGroupWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
