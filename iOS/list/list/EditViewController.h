#import <UIKit/UIKit.h>
#import "Contact.h"

@class EditViewController;


@interface EditViewController : UIViewController

@property (nonatomic, strong) Contact *conctact;
@property (nonatomic, weak) UITableView *tableView;

@end

