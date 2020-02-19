#import <Foundation/Foundation.h>
#import "Player.h"
#import "Robot.h"

NS_ASSUME_NONNULL_BEGIN

@interface Judge : NSObject
{
    @public
    NSString *_name;
}
- (void)JudgementWithPlayer:(Player *)player andRobot:(Robot *)robot;
@end

NS_ASSUME_NONNULL_END
