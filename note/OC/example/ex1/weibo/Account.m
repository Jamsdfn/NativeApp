#import "Account.h"

@implementation Account

- (void)dealloc{
    NSLog(@"账户已退出");
    [_password release];
    [_userName release];
    [super dealloc];
}

@end
