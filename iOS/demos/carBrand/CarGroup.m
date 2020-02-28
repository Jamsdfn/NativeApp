#import "CarGroup.h"
#import "Car.h"
@implementation CarGroup

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        // 模型嵌套
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in dict[@"cars"]) {
            Car *model = [Car carWithDictionary:item];
            [arrM addObject:model];
        }
        self.cars = arrM;
    }
    return self;
}

+ (instancetype)carGroupWithDictionary:(NSDictionary *)dict{
    return [[CarGroup alloc] initWithDictionary:dict];
}

@end
