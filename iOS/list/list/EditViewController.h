#import <UIKit/UIKit.h>
#import "Contact.h"

@class EditViewController;

@protocol EditViewControllerDelegate <NSObject>

@required
- (void)editViewController:(EditViewController*)editViewController;

@end

@interface EditViewController : UIViewController

@property (nonatomic, strong) Contact *conctact;
@property (nonatomic, weak) id<EditViewControllerDelegate> delegate;

@end

