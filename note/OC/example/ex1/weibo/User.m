#import "User.h"

@implementation User

- (void)dealloc{
    NSLog(@"用户信息丢失");
    [_account release];
    [_nicName release];
    [super dealloc];
}

@end
