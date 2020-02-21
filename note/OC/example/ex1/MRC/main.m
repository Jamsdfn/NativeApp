#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
//    Person *p1 = [Person new];
//    p1.name = @"Jack";
//    NSLog(@"retainCount is %lu", [p1 retainCount]);
//    [p1 release];
    @autoreleasepool {
        Person *p1 = [[Person new] autorelease];// 创建对象并把对象存入自动释放池中
        p1.name = @"Jack";
        
    }
    return 0;
}
