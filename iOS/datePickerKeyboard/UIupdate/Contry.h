#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contry : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)contryWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
