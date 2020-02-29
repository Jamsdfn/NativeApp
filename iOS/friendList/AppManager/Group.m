#import "Group.h"
#import "Friend.h"
@implementation Group



- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in self.friends) {
            Friend *model = [Friend friendWithDictionary:item];
            [arrM addObject:model];
        }
        self.friends = arrM;
    }
    return self;
}

+ (instancetype)groupWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
