#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

#define textFont [UIFont systemFontOfSize:14]

@class Message;

NS_ASSUME_NONNULL_BEGIN

@interface MessageFrame : NSObject

@property (nonatomic, strong) Message *message;
@property (nonatomic, assign, readonly) CGRect timeFrame, iconFrame, textFrame;
@property (nonatomic, assign) CGFloat rowHeight;


@end

NS_ASSUME_NONNULL_END
