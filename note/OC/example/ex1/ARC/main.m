#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    __strong Person *p1 = [Person new];
    __weak Person *p2 = p1;
    p1 = nil;
    [p1 sayHi];
    [p2 sayHi];
    return 0;
}
