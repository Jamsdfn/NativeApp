#import "CarGroup.h"

@implementation CarGroup

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)carGroupWithDictionary:(NSDictionary *)dict{
    return [[CarGroup alloc] initWithDictionary:dict];
}

@end
