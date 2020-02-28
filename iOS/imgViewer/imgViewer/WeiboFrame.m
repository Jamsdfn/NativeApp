#import "WeiboFrame.h"
#import "Weibo.h"


@implementation WeiboFrame

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.weibo = [Weibo weiboWithDictionary:dict];
    }
    return self;
}

+ (instancetype)weiboFrameWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setWeibo:(Weibo *)weibo{
    _weibo = weibo;
    CGFloat margin = 10;
    
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 根据label中的内动态计算label的高宽
    CGSize nameSize = [self sizeWithText:weibo.name andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) andFont:nameFont];
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + margin;
    CGFloat nameY = iconY + (iconH / 2) - (nameSize.height / 2);
    _nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    
    CGFloat vipW = 10;
    CGFloat vipH = 10;
    CGFloat vipX = CGRectGetMaxX(self.nameFrame) + margin;
    CGFloat vipY = iconY + (iconH / 2) - (vipH / 2);
    _vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + margin;
    CGSize textSize = [self sizeWithText:weibo.text andMaxSize:CGSizeMake(360, MAXFLOAT) andFont:textFont];
    _textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    CGFloat picX = iconX;
    CGFloat picY = CGRectGetMaxY(self.textFrame) + margin;
    CGFloat picW = 100;
    CGFloat picH = 100;
    _picFrame = CGRectMake(picX, picY, picW, picH);
    
    CGFloat rowHeight = 0;
    if (weibo.picture) {
        rowHeight = CGRectGetMaxY(self.picFrame) + margin;
    } else {
        rowHeight = CGRectGetMaxY(self.textFrame) + margin;
    }
    _rowHeight = rowHeight;
}
- (CGSize)sizeWithText:(NSString *)text andMaxSize:(CGSize)maxSize andFont:(UIFont *)font{
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
}

@end
