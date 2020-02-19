//#import <Foundation/Foundation.h>
#import "Person.h"

@implementation Person

- (void)sayHi {
    NSLog(@"Hi");
}

- (void)dogShout:(Dog *)dog {
    [dog sayHi];
}

- (Dog *)createDog {
    return [Dog new];
}
@end
