#import "Person.h"

@implementation Person

//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//  static id instance = nil;
//  if (!instance) {
//    instance = [super allocWithZone:zone];
//  }
//  return instance;
//}

- (void)run{
    NSLog(@"running....");
}

- (void)dealloc
{
    NSLog(@"人没了");
}

- (void)sayHi{
    NSLog(@"Hi");
}

- (void)sleep{
    NSLog(@"zzzzzzz....");
}
@end
