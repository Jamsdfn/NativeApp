#import <Foundation/Foundation.h>
#import "Person.h"
#import "Dog.h"

#pragma mark -
int main(int argc, const char *argv[]) {
    Person *p1 = [Person new];
    [p1 sayHi];
    Dog *d1 = [Dog new];
    [p1 dogShout:d1];
    Dog *d2 = [p1 createDog];
    [d2 sayHi];
    return 0;
}
