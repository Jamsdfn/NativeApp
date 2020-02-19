#import <Foundation/Foundation.h>
#import "FistType.h"

NS_ASSUME_NONNULL_BEGIN

@interface Player : NSObject
{
    @public
    NSString *_name;
    int _score;
    FistType _selectedType;
}
- (void)showFist;
- (NSString *)fistTypeWithNumber:(int)number;
@end

NS_ASSUME_NONNULL_END
