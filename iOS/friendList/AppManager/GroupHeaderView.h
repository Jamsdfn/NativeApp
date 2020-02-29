#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Group;
@class GroupHeaderView;
@protocol GroupHeaderViewDelegate <NSObject>
@required
- (void)reload:(GroupHeaderView *)groupHeaderView;

@end


@interface GroupHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) Group *group;
@property (nonatomic, weak) id<GroupHeaderViewDelegate> delegate;

+ (instancetype)groupHeaderViewWithtableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
