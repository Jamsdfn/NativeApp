#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+test.h"
#import "Account.h"

#define log(var) NSLog(@"%@", var==YES?@"YES":@"NO")

int main(int argc, const char * argv[]) {
    Person *p1 = [Person new];
    Person *p2 = [Person new];
    Person *p3 = [Person new];
    Person *p4 = [Person new];
    return 0;
}
