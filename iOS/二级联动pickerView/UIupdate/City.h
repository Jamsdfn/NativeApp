#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface City : NSObject

@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, copy) NSString *name;


- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)cityWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
