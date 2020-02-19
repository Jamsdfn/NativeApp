#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject {
    @public
    NSString *_name;
    int _age;
}

- (void)sayHi;
- (void)dogShout:(Dog *)dog;
- (Dog *)createDog;
@end
