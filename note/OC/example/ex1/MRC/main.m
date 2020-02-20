#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    Person *p1 = [Person new];
    p1.name = @"Jack";
    NSLog(@"retainCount is %lu", [p1 retainCount]);
    [p1 release];
    return 0;
}
