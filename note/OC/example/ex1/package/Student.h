#import "Person.h"
NS_ASSUME_NONNULL_BEGIN

@interface Student : Person
{
    NSString *_stuNumber;
}
- (void)setStuNumber:(NSString *)Id;
- (NSString *)stuNumber;

@end

NS_ASSUME_NONNULL_END
