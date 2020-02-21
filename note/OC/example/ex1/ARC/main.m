#import <Foundation/Foundation.h>
#import "Person.h"
#import "Person+test.h"
#import "Account.h"

typedef int (^NewType1)(int, int);
typedef void (^dd)();

void test(dd block1){
  NSLog(@"----------");
  block1();
  NSLog(@"----------");
}

void test1(int (^test)(int num1, int num2)) {
    NSLog(@"----------");
    NSLog(@"%d",test(10, 20));
    NSLog(@"----------");
}

int main(int argc, const char * argv[]) {
    test(^{
        NSLog(@"123");
    });
    
    test1(^int(int num1, int num2) {
        return num1 * num2;
    });
    
    Person *p1 = [Person new];
    [p1 haha];
    [[Person new] haha];
    NewType1 myBlock = ^(int num1, int num2){
        return num1 + num2;
    };
    int sum = myBlock(1,2);
    NSLog(@"%d",sum);
    void (^myBlock1)(void) = ^{
        NSLog(@"a");
    };
    myBlock1();
    int (^myBlock2)(void) = ^{
        return 1;
    };
    NSLog(@"%d",myBlock2());
    return 0;
}
