#import <UIKit/UIKit.h>
#import "Goods.h"
NS_ASSUME_NONNULL_BEGIN

@interface GoodsCell : UITableViewCell

@property (nonatomic, strong) Goods *good;

+ (instancetype)goodsCellWithidentifier:(NSString *)identifier andTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
