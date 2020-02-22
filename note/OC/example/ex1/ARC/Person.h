#import <Foundation/Foundation.h>
#import "pro.h"


NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject <pro>
@property NSString *name;
@property int age;

- (void)sayHi;

@end

NS_ASSUME_NONNULL_END
