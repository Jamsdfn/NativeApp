#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(nonatomic,retain) NSString *name;
@property(nonatomic) int age;

- (void)sayHi;
@end

NS_ASSUME_NONNULL_END
