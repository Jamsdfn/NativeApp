#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYView : UIView

@property (nonatomic, assign) CGFloat value;

- (void)setProgressValue:(CGFloat)value;

@end

NS_ASSUME_NONNULL_END
