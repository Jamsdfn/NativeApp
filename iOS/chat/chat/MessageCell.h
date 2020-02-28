#import <UIKit/UIKit.h>
#import "MessageFrame.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageCell : UITableViewCell

@property (nonatomic, strong) MessageFrame *messageFrame;

+ (instancetype)messageCellWithTableView:(UITableView *)tableView andIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
