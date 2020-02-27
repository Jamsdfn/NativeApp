#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarGroup : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *cars;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)carGroupWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
