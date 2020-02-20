#import <Foundation/Foundation.h>

@interface Person : NSObject 

@property int age;
@property NSString *name;
@property float height;
@property float weight;

+ (instancetype)createSelf;
- (void)show;
- (instancetype)initWith:(NSString *)name andAge:(int)age;

@end
