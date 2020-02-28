#import <UIKit/UIKit.h>
@class App;
//#import "App.h"

@interface AppView : UIView

@property (nonatomic, strong) App *model;

+ (instancetype)appView;

@end

