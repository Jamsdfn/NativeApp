#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject {
    NSString *_name;
    int _age;
}

- (void)show;

- (void)setAge:(int)age;
- (int)age;

- (void)setName:(NSString *)name;
- (NSString *)name;

@end
