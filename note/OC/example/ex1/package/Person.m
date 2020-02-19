#import "Person.h"

@implementation Person

- (void)liuDog:(Dog *)dog{
    NSLog(@"%@去遛%@色的%@", _name, dog->_color, dog->_name);
    [dog shout];
}

@end
