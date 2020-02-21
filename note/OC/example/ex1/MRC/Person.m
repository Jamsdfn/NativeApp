#import "Person.h"

@implementation Person
- (void)sayHi{
    NSLog(@"Hi");
}
- (void)dealloc{
    NSLog(@"%@对象被回收", _name);
    [_name release];
    [super dealloc];
}
@end
