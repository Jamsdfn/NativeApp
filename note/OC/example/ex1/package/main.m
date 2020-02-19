#import <Foundation/Foundation.h>
#import "Person.h"
#import "Student.h"
int main(int argc, const char * argv[]) {
    Person *p1 = [Person new];
    [p1 setAge:22];
    [p1 setName:@"xiaohua"];
    [p1 show];
    Student *s = [Student new];
    [s setStuNumber:@"10086"];
    NSLog(@"student id is %@",[s stuNumber]);
    [s setName:@"ming"];
    [s setAge:16];
    [s show];
    return 0;
}
