#import "Student.h"

@implementation Student


- (void)show{
     NSLog(@"我叫%@，今年%d岁了，身高%f，体重%f，学号是%@", self.name, self.age, self.height, self.weight, self.stuNumber);
}
@end
