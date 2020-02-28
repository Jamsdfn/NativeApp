#import <UIKit/UIKit.h>
#import "MessageFrame.h"
#import "Message.h"
#import "NSString+NSStringExt.h"
@implementation MessageFrame

- (void)setMessage:(Message *)message{
    _message = message;
    
    CGFloat margin = 10;
    CGFloat screenW =  [UIScreen mainScreen].bounds.size.width;
    
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    CGFloat timeW = screenW;
    CGFloat timeH = 15;
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    CGFloat iconW = 30;
    CGFloat iconH = 30;
    CGFloat iconX = message.type == MessageTypeOther ? margin : (screenW - (margin + iconW));
    CGFloat iconY = CGRectGetMaxY(_timeFrame) + margin;
    if (message.hideTime){
        iconY = 0;
    }
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGSize textSize = [message.text sizeOfTextWithMaxSize:CGSizeMake(234, MAXFLOAT) font:textFont];
    CGFloat textY = iconY;
    CGFloat textX = message.type == MessageTypeOther ? CGRectGetMaxX(_iconFrame) : iconX - textSize.width;
    _textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    
    CGFloat maxY = MAX(CGRectGetMaxY(_textFrame), CGRectGetMaxY(_iconFrame));
    _rowHeight = maxY + margin;
}


@end
