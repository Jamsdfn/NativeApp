#import <UIKit/UIKit.h>

@class FooterView;

@protocol FooterViewDelegate <NSObject>
@required
- (void)footerViewUpdateData:(FooterView * _Nonnull)footerView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FooterView : UIView
//@property (weak, nonatomic) UITableView *tableView;
// UI控件的代理必须使用weak
@property (nonatomic, weak) id<FooterViewDelegate> delegate;

+ (instancetype)footerView;
@end

NS_ASSUME_NONNULL_END


