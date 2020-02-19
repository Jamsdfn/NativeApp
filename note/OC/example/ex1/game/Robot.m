#import "Robot.h"
#import <stdlib.h>
@implementation Robot
- (void)showFist {
    int robotSelect = arc4random_uniform(3) + 1;
    NSLog(@"机器人[%@]出得是：%@", _name, [self fistTypeWithNumber:robotSelect]);
    _selectType = robotSelect;
}
- (NSString *)fistTypeWithNumber:(int)number {
    switch (number)
    {
        case 1:
            return @"剪刀";
        case 2:
            return @"石头";
        default:
            return @"布";
    }
}
@end
