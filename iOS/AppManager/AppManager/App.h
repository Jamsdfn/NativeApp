#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface App : NSObject

@property (nonatomic, copy) NSString *size;
@property (nonatomic, copy) NSString *download;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) BOOL isDownload;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)appWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
