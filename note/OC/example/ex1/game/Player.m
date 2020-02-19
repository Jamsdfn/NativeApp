#import "Player.h"

@implementation Player
- (void)showFist {
    NSLog(@"亲爱的玩家[%@]请选择你要出的拳头 1.剪刀 2.石头 3.布（输入其他东西默认为布）", _name);
    int userSelect = 0;
    scanf("%d", &userSelect);
    NSString *fist = [self fistTypeWithNumber:userSelect];
    NSLog(@"玩家[%@]出的拳头是：%@", _name, fist);
    _selectedType = userSelect;
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
