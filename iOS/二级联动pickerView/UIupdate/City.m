#import "City.h"

@implementation City

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cityWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
