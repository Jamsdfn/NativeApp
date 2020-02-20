#import "Person.h"

@implementation Person
- (void)sayHi{
    NSLog(@"Hi");
}
- (void)dealloc{
    NSLog(@"%@对象被回收",_name);
    [super dealloc];
}
@end
