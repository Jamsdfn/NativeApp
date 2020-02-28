#import "AppView.h"
#import "App.h"
@interface AppView ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)download:(UIButton *)sender;


@end

@implementation AppView


- (void)setModel:(App *)model{
    _model = model;
    
    self.imgViewIcon.image = [UIImage imageNamed:model.icon];
    self.lblName.text = model.name;
    
}

+ (instancetype)appView{
    // 因为xib安装到App上手变成了加密方式的nil，所以方法名是loadNibNamed,并且这个方法返回的是数组，因此再调用一个lastObject来选择最后一个view（创建的时候只创建了一个）
    // 注意loadNibNamed参数不要加后缀
    return [[[NSBundle mainBundle] loadNibNamed:@"AppView" owner:nil options:nil] lastObject];
}

- (IBAction)download:(UIButton *)sender {
    sender.enabled = NO;
    UILabel *lblMsg = [UILabel new];
    lblMsg.text = @"正在下载......";
    lblMsg.backgroundColor = [UIColor colorWithDisplayP3Red:0.5 green:0.5 blue:0.5 alpha:1];
    
    CGFloat msgW = 200;
    CGFloat msgH = 50;
    CGFloat msgX = (self.superview.frame.size.width - msgW) / 2;
    CGFloat msgY = (self.superview.frame.size.height - msgH) / 2;
    
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
    lblMsg.textColor = [UIColor whiteColor];
    lblMsg.textAlignment = NSTextAlignmentCenter;
    lblMsg.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    // 圆角设置，圆心设置
    lblMsg.layer.cornerRadius = 15;
    // 裁去多余部分
    lblMsg.layer.masksToBounds = YES;
    lblMsg.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        lblMsg.alpha = 0.75;
    } completion:^(BOOL finished) {
        if (finished) {
            // 出来后等一秒就消失
            [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
                lblMsg.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [lblMsg removeFromSuperview];
                }
            }];
        }
    }];
    // 放入控制器的大View上
    [self.superview addSubview:lblMsg];
}
@end
