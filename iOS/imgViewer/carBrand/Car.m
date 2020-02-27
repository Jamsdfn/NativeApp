#import "Car.h"

@implementation Car

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)carWithDictionary:(NSDictionary *)dict{
    return [[Car alloc] initWithDictionary:dict];
}

@end
