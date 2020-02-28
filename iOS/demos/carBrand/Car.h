#import <Foundation/Foundation.h>


@interface Car : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)carWithDictionary:(NSDictionary *)dict;

@end

