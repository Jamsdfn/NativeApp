#import <Foundation/Foundation.h>

typedef enum {
    MessageTypeMe,
    MessageTypeOther
} MessageType;

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageType type;
@property (nonatomic, assign) BOOL hideTime;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)messageWithDictionary:(NSDictionary *)dict;

@end

