//
//  UIView+test.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/24.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "UIView+test.h"

// 这个头文件能让程序运行期间增加属性，也可以在运行时获取某个对象的所有属性名称，交换方法
#import <objc/runtime.h>

@implementation UIView (test)
- (NSString *)str{
    // 获取那个对象的什么属性
    return objc_getAssociatedObject(self, "str");
}
- (void)setStr:(NSString *)str{
    // 参数一：哪个对象要加属性，参数二：添加的属性的名字（c字符串)，参数三：属性的值,参数四：property的属性
    objc_setAssociatedObject(self, "str", str, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
