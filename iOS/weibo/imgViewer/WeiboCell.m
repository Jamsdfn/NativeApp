#import "WeiboCell.h"
#import "WeiboFrame.h"
#import "Weibo.h"
#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:14]

@interface WeiboCell ()

@property (nonatomic, weak) UIImageView *imgViewIcon, *imgViewVip, *imgViewPicture;
@property (nonatomic, weak) UILabel *lblNickName, *lblText;

@end

@implementation WeiboCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setWeiboFrame:(WeiboFrame *)weiboFrame{
    _weiboFrame = weiboFrame;
    // 设置数据
    [self setData];
    // 设置frame
    [self setCellFrame];
}


- (void)setData{
    WeiboFrame *frame = self.weiboFrame;
    Weibo *model = frame.weibo;
    self.imgViewIcon.image = [UIImage imageNamed:model.icon];
    self.lblNickName.text = model.name;
    if (model.isVip) {
        self.imgViewVip.hidden = NO;
    } else {
        self.imgViewVip.hidden = YES;
    }
    self.lblText.text = model.text;
    if (model.picture) {
        self.imgViewPicture.image = [UIImage imageNamed:model.picture];
        self.imgViewPicture.hidden = NO;
    } else {
        self.imgViewPicture.image = nil;
        self.imgViewPicture.hidden = YES;
    }
}

- (CGSize)sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
}

- (void)setCellFrame{
    self.imgViewIcon.frame = self.weiboFrame.iconFrame;
    self.lblNickName.frame = self.weiboFrame.nameFrame;
    if (self.weiboFrame.weibo.isVip) {
        self.lblNickName.textColor = [UIColor redColor];
    } else {
        self.lblNickName.textColor = [UIColor blackColor];
    }
    self.imgViewVip.frame = self.weiboFrame.vipFrame;
    self.lblText.frame = self.weiboFrame.textFrame;
    self.imgViewPicture.frame = self.weiboFrame.picFrame;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        // 创建子控件
        // 头像
        UIImageView *imgViewIcon = [UIImageView new];
        self.imgViewIcon = imgViewIcon;
        [self.contentView addSubview:imgViewIcon];
        
        // 昵称
        UILabel *lblNickName = [UILabel new];
        lblNickName.font = nameFont;
        self.lblNickName = lblNickName;
        [self.contentView addSubview:lblNickName];
        
        // 会员
        UIImageView *imgViewVip = [UIImageView new];
        imgViewVip.image = [UIImage imageNamed:@"vip"];
        self.imgViewVip = imgViewVip;
        [self.contentView addSubview:imgViewVip];
        
        // 正文
        UILabel *lblText = [UILabel new];
        lblText.font = textFont;
        lblText.numberOfLines = 0;
        self.lblText = lblText;
        [self.contentView addSubview:lblText];
        
        // 配图
        UIImageView *imgViewPicture = [UIImageView new];
        self.imgViewPicture = imgViewPicture;
        [self.contentView addSubview:imgViewPicture];
        
    }
    return self;
}

@end
