#import <Foundation/Foundation.h>

typedef struct {
    int year;
    int month;
    int day;
} myDate;

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject

@property(nonatomic, retain)NSString *userName;
@property(nonatomic, retain)NSString *password;
@property(nonatomic, assign)myDate registDate;

@end

NS_ASSUME_NONNULL_END
