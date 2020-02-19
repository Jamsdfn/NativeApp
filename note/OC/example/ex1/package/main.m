#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    
    Person *p1 = [Person new];
    [p1 setAge:22];
    [p1 setName:@"xiaohua"];
    [p1 show];
    NSLog(@"%@,%d岁",[p1 name], [p1 age]);
    return 0;
}
