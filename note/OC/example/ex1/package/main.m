#import <Foundation/Foundation.h>
int main(int argc, const char * argv[]) {
    NSString *str = @"中国我爱你";
    unichar ch = [str characterAtIndex:2]; // 啊
    NSLog(@"ch = %C", ch);// 啊，注意这里时大写的C
    return 0;
}
