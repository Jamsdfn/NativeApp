#import "Student.h"

@implementation Student

- (void)setStuNumber:(NSString *)Id{
    _stuNumber = Id;
}
- (NSString *)stuNumber{
    return _stuNumber;
}
- (void)show{
     NSLog(@"我叫%@，今年%d岁了，身高%f，体重%f，学号是%@", _name, _age, _height, _weight, _stuNumber);
}
@end
