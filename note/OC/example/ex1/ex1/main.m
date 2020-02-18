#import <Foundation/Foundation.h>

#pragma mark Student的声明
@interface Student : NSObject {
    @public
    NSString *_name;
    int _age;
    int _Chinese;
    int _math;
    int _English;
}
- (void)run;
- (void)eat:(NSString *)food;
- (int)sum:(int)num1 :(int)num2;
- (int)sumWith:(int)num1 and:(int)num2;
@end
#pragma mark Student的实现
@implementation Student
- (void)run {
    NSLog(@"Running...");
}

- (void)eat:(NSString *)food {
  NSLog(@"eating %@", food);
}

- (int)sum:(int)num1 :(int)num2 {
  return num1 + num2;
}

- (int)sumWith:(int)num1 and:(int)num2 {
  return num1 + num2;
}
@end
#pragma mark -
int main(int argc, const char *argv[]) {
    Student *s1 = [Student new];
    s1->_name = @"Leo";
    s1->_age = 18;
    s1->_math = 100;
    s1->_Chinese = 100;
    s1->_English = 100;
    
    NSLog(@"Student s1 called %@, age is %d, math's Score is %d, Chinese's Score is %d, English's Score is %d",
          s1->_name,
          s1->_age,
          s1->_math,
          s1->_Chinese,
          s1->_English
          );
    [s1 run];
    [s1 eat:@"bat"];
    int sum = [s1 sum:1 :2];
    int sum1 = [s1 sumWith:1 and:2];
    NSLog(@"%d %d", sum, sum1);
    return 0;

}
