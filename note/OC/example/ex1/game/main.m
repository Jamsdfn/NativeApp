/*
    玩家类
        属性：姓名、出什么、得分
        行为：出拳
    机器人类
        属性：姓名、出什么、得分
        行为：随机出拳
    裁判类
        属性：姓名
        行为：裁决显示分数
 */

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Robot.h"
#import "Judge.h"
int main() {
    Player *p = [Player new];
    p->_name = @"小明";
    
    Robot *r = [Robot new];
    r->_name = @"1号";
    
    Judge *j = [Judge new];
    j->_name = @"蜻蜓队长";
    while(1) {
        [p showFist];
        [r showFist];
        [j JudgementWithPlayer:p andRobot:r];
        
        NSLog(@"再来一局？y/n");
        char ans = 'a';
        rewind(stdin);
        scanf("%c", &ans);
        if(ans != 'y'){
            NSLog(@"欢迎下次光临!");
            break;
        }
        
    }
    
    return 0;
}
