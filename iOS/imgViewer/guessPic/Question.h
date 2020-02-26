#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Question : NSObject


@property (nonatomic, copy) NSString *answer;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *options;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)questionWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
