#import <Foundation/Foundation.h>
#import "Account.h"
NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property(nonatomic,retain)NSString *nicName;
@property(nonatomic,assign)myDate birthday;
@property(nonatomic,retain)Account *account;

@end

NS_ASSUME_NONNULL_END
