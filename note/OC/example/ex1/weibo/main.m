/*
 微博类 属性：文字内容、图片、发表时间、作者、被转发的微博、评论数、转发数、点赞数
 作者类 属性：名称、生日、账号
 账号类 属性：账号名称、账号密码、注册时间
 */
#import <Foundation/Foundation.h>
#import "Microblog.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Account *a1 = [[Account new] autorelease];
        a1.userName = @"mike";
        a1.password = @"123";
        a1.registDate = (myDate){2020,2,20};
        
        User *mike = [[User new] autorelease];
        mike.nicName = @"littleMike";
        mike.account = a1;
        mike.birthday = (myDate){2020,2,19};
        
        Microblog *m1 = [[Microblog new] autorelease];
        m1.content = @"nice day";
        m1.imgURL = @"https://raw.githubusercontent.com/Jamsdfn/wweebb/master/upload/php/ali_project/static/uploads/avatar.jpg";
        m1.user = mike;
        m1.sendTime = (myDate){2020,2,21};
        // m1.forwordBlog = nil;
        m1.likeNumber = 1;
        m1.forwordNumber = 0;
        m1.commentNumber = 0;
        
        
        Account *a2 = [[Account new] autorelease];
        a2.userName = @"mike";
        a2.password = @"123";
        a2.registDate = (myDate){2020,2,20};
        
        User *Jack = [[User new] autorelease];
        Jack.nicName = @"littleJack";
        Jack.account = a2;
        Jack.birthday = (myDate){2020,2,19};
        
        Microblog *m2 = [[Microblog new] autorelease];
        m2.content = @"I don't think so";
        m2.imgURL = @"https://raw.githubusercontent.com/Jamsdfn/wweebb/master/upload/php/ali_project/static/uploads/avatar.jpg";
        m2.user = Jack;
        m2.sendTime = (myDate){2020,2,21};
        m2.forwordBlog = m1;
        m2.likeNumber = 1;
        m2.forwordNumber = 0;
        m2.commentNumber = 0;
    }
    return 0;
}
