#import "Person.h"

@implementation Person

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
