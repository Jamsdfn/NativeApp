//
//  CustomOperation.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/24.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "CustomOperation.h"
#import "NSString+Sandbox.h"
@implementation CustomOperation

// 重写mian方法，在里面进行操作
- (void)main{
    // 子线程或者循环会产生大量的临时变量都要加自动释放池
    @autoreleasepool {
        NSLog(@"正在下载... %@", self.urlString);
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.urlString]];
        UIImage *image = [UIImage imageWithData:data];
        // 判断是否被取消，是的话直接返回，停止当前操作
        if (self.isCancelled) {
            return;
        }
        // 缓存
        if (data) {
            [data writeToFile:[self.urlString appendCache] atomically:YES];
            
        }
        if (self.finishedBlock) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.finishedBlock(image);
            }];
        }
    }
}

+ (instancetype)customOperationWithURLString:(NSString *)urlString andFinishedBlock:(void (^)(UIImage * _Nonnull))finishedBlock{
    CustomOperation *op =[[CustomOperation alloc] init];
    op.urlString = urlString;
    op.finishedBlock = finishedBlock;
    return op;
}
@end
