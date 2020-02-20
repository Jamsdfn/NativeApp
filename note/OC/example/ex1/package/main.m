#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
int main(int argc, const char * argv[]) {
    Person *p1 = [Person new];
    p1.age = 10;
    p1.name = @"dog";
    p1.height = 1.5f;
    p1.weight = 100;
    [p1 show];
    return 0;
}
