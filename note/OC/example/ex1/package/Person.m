#import "Person.h"

@implementation Person

- (void)show{
    NSLog(@"我叫%@，今年%d岁了，身高%f，体重%f", _name, _age, _height, _weight);
}

- (void)setAge:(int)age {
    if (age >= 0 && age <= 200){
        _age = age;
    } else {
        _age = 18;
    }
}

+ (instancetype)createSelf{
    return [self new];
}

- (instancetype)init{
  if (self = [super init]){
    self.name = @"jack";
  }
  return self;
}

- (instancetype)initWith:(NSString *)name andAge:(int)age {
if (self = [super init]){
    self.name = name;
    self.age = age;
  }
  return self;
}

@end
