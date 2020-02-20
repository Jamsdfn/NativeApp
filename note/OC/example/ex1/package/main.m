#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
int main(int argc, const char * argv[]) {
    Person *p1 = [Person createSelf];
    p1.age = 10;
//    p1.name = @"dog";
    p1.height = 1.5f;
    p1.weight = 100;
    [p1 show];
    Person *p2 = [[Person alloc] initWith:@"ma" andAge:18];
    [p2 show];
    Student *s1 = [Student createSelf];
    s1.age = 10;
    s1.name = @"dog";
    s1.height = 1.5f;
    s1.weight = 100;
    s1.stuNumber = @"10086";
    [s1 show];
    return 0;
}
