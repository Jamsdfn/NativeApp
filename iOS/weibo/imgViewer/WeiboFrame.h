#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#define nameFont [UIFont systemFontOfSize:12]
#define textFont [UIFont systemFontOfSize:14]

@class Weibo;
NS_ASSUME_NONNULL_BEGIN

@interface WeiboFrame : NSObject

@property (nonatomic, strong) Weibo *weibo;
@property (nonatomic, assign, readonly) CGRect iconFrame, nameFrame, vipFrame, textFrame, picFrame;
@property (nonatomic, assign, readonly) int rowHeight;

+ (instancetype)weiboFrameWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
