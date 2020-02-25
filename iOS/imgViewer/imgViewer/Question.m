#import "Question.h"

@implementation Question

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.answer = dict[@"answer"];
        self.title = dict[@"title"];
        self.icon = dict[@"icon"];
        self.options = dict[@"options"];
    }
    return self;
}

+ (instancetype)questionWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

@end
