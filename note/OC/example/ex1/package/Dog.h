#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject {
    @public
    NSString *_name;
    NSString *_color;
}

- (void)shout;

@end

NS_ASSUME_NONNULL_END
