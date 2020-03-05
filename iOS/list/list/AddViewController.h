#import <UIKit/UIKit.h>
#import "Contact.h"

@class AddViewController;

@protocol AddViewControllerDelegate <NSObject>

@required
- (void)addViewController:(AddViewController*)addViewController withContact:(Contact*)contactInfo;

@end

@interface AddViewController : UIViewController

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;

@end

