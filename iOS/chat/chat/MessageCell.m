#import "MessageCell.h"
#import "Message.h"

@interface MessageCell ()

@property (nonatomic, weak) UILabel *lblTime;
@property (nonatomic, weak) UIImageView *imgViewIcon;
@property (nonatomic, weak) UIButton *btnText;

@end

@implementation MessageCell

+ (instancetype)messageCellWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier{
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建子控件
        UILabel *lblTime = [UILabel new];
        lblTime.font = [UIFont systemFontOfSize:12];
        lblTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lblTime];
        self.lblTime = lblTime;
        
        UIImageView *imgViewIcon = [UIImageView new];
        [self.contentView addSubview:imgViewIcon];
        self.imgViewIcon = imgViewIcon;
        
        UIButton *btnText = [UIButton new];
        btnText.titleLabel.font = textFont;
//        btnText.userInteractionEnabled = NO;
        [btnText setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btnText.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:btnText];
        self.btnText = btnText;
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setMessageFrame:(MessageFrame *)messageFrame{
    _messageFrame = messageFrame;
    // 分别设置数据和frame
    Message *message = messageFrame.message;
    
    self.lblTime.text = message.time;
    self.lblTime.frame = messageFrame.timeFrame;
    self.lblTime.hidden = message.hideTime;
    
    [self.btnText setTitle:message.text forState:UIControlStateNormal];
    self.btnText.frame = messageFrame.textFrame;
    NSString *imgNormal, *imgHighlighted;
    if (message.type == MessageTypeMe) {
        imgNormal = @"chat_send_nor";
        imgHighlighted = @"chat_send_press_pic";
    } else {
        imgNormal = @"chat_recive_nor";
        imgHighlighted = @"chat_recive_press_pic";
    }
    UIImage *imageNormal = [UIImage imageNamed:imgNormal];
    UIImage *imageHighlighted = [UIImage imageNamed:imgHighlighted];
    
    imageNormal = [imageNormal stretchableImageWithLeftCapWidth:imageNormal.size.width/2 topCapHeight:imageNormal.size.height/2];
    imageHighlighted = [imageHighlighted stretchableImageWithLeftCapWidth:imageHighlighted.size.width/2 topCapHeight:imageHighlighted.size.height/2];
    
    [self.btnText setBackgroundImage:imageNormal forState:UIControlStateNormal];
    [self.btnText setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
    // 用平铺的方式拉伸图片
    
    NSString *iconImg = message.type == MessageTypeMe ? @"me" : @"other";
    self.imgViewIcon.image = [UIImage imageNamed:iconImg];
    self.imgViewIcon.frame = messageFrame.iconFrame;
    
    
}


@end
