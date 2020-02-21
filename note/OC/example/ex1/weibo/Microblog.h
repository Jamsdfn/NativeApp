// 文字内容、图片、发表时间、作者、被转发的微博、评论数、转发数、点赞数
#import <Foundation/Foundation.h>
#import "User.h"
NS_ASSUME_NONNULL_BEGIN

@interface Microblog : NSObject

@property(nonatomic,retain)NSString *content;
@property(nonatomic,retain)NSString *imgURL;
@property(nonatomic,assign)myDate sendTime;
@property(nonatomic,retain)User *user;
@property(nonatomic,retain)Microblog *forwordBlog;
@property(nonatomic,assign)int forwordNumber;
@property(nonatomic,assign)int likeNumber;
@property(nonatomic,assign)int commentNumber;

@end

NS_ASSUME_NONNULL_END
