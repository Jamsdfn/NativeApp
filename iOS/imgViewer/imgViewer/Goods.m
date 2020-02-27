#import "Goods.h"

@implementation Goods

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)goodsWithDictionary:(NSDictionary *)dict{
    return [[Goods alloc] initWithDictionary:dict];
}

@end
