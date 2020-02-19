#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject {
    @public
    NSString *_name;
    int _age;
}

- (void)sayHi;

@end

NS_ASSUME_NONNULL_END
