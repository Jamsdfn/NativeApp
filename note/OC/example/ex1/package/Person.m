#import "Person.h"

@implementation Person

- (void)show{
    NSLog(@"我叫%@，今年%d岁了", _name, _age);
}

- (void)setAge:(int)age {
    if (age >= 0 && age <= 200){
        _age = age;
    } else {
        _age = 18;
    }
}
- (int)age {
    return _age;
}

- (void)setName:(NSString *)name{
    _name = name;
}
- (NSString *)name {
    return _name;
}

@end
