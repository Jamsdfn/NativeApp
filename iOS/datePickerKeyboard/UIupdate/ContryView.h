#import <UIKit/UIKit.h>
@class Contry;
NS_ASSUME_NONNULL_BEGIN

@interface ContryView : UIView

@property (nonatomic, strong) Contry *contry;

+ (instancetype)contryView;

@end

NS_ASSUME_NONNULL_END
