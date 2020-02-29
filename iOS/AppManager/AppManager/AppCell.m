#import "AppCell.h"
#import "App.h"

@interface AppCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblIntro;
@property (weak, nonatomic) IBOutlet UIButton *btnDownload;
- (IBAction)btnDownloadClick;


@end


@implementation AppCell

- (void)setApp:(App *)app{
    _app = app;
    self.imageViewIcon.image = [UIImage imageNamed:app.icon];
    self.lblName.text = app.name;
    self.lblIntro.text = [NSString stringWithFormat:@"大小:%@ | 下载量:%@", app.size, app.download];
    self.btnDownload.enabled = app.isDownload ? NO : YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnDownloadClick {
    self.btnDownload.enabled = NO;
    // 弹出消息框
    self.app.isDownload = YES;
//    NSLog(@"%@", NSStringFromCGRect(self.superview.frame) );
    UILabel *lblMsg = [UILabel new];
    lblMsg.text = @"正在下载....";
    lblMsg.backgroundColor = [UIColor blackColor];
    lblMsg.textColor = [UIColor redColor];
    CGFloat msgW = 200;
    CGFloat msgH = 40;
    CGFloat msgX = (self.superview.superview.frame.size.width - msgW) / 2;
    CGFloat msgY = ((self.superview.superview.frame.size.height - msgH) / 2) - 20;
    lblMsg.frame = CGRectMake(msgX, msgY, msgW, msgH);
    lblMsg.font = [UIFont systemFontOfSize:18];
    lblMsg.textAlignment = NSTextAlignmentCenter;
    lblMsg.alpha = 0.0;
    lblMsg.layer.cornerRadius = 5;
    lblMsg.layer.masksToBounds = YES;
    [self.superview.superview addSubview:lblMsg];
    [UIView animateWithDuration:1 animations:^{
        lblMsg.alpha = 0.6;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
                lblMsg.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [lblMsg removeFromSuperview];
                }
            }];
        }
    }];
    
}
@end
