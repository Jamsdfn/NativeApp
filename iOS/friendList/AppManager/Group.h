#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Group : NSObject

@property (nonatomic, strong) NSArray *friends;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int online;
@property (nonatomic, assign) BOOL isVisible;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)groupWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
