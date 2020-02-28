#import "Weibo.h"

@implementation Weibo

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)weiboWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
