#import "Microblog.h"

@implementation Microblog

- (void)dealloc
{
    NSLog(@"微博没了");
    [_content release];
    [_imgURL release];
    [_user release];
    [_forwordBlog release];
    [super dealloc];
}

@end
