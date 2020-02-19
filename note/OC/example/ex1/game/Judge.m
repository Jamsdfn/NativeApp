#import "Judge.h"
#import "FistType.h"
@implementation Judge
- (void)JudgementWithPlayer:(Player *)player andRobot:(Robot *)robot {
    FistType playerFist = player->_selectedType;
    FistType robotFist = robot->_selectType;
    NSLog(@"裁判[%@]，结果为：", _name);
    if(playerFist - robotFist == -2 || playerFist - robotFist == 1) {
        NSLog(@"玩家[%@]胜", player->_name);
        player->_score++;
    } else if(playerFist == robotFist){
        NSLog(@"平局");
    } else {
        NSLog(@"机器人[%@]胜", robot->_name);
        robot->_score++;
    }
    NSLog(@"当前得分玩家[%@]%d分，机器人[%@]%d分",player->_name, player->_score, robot->_name, robot->_score);
}
@end
