#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Friend;

@interface FriendCell : UITableViewCell

@property (nonatomic, strong) Friend *friendModel;

+ (instancetype)friendCellWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
