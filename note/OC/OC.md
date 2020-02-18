# Objective-C

OC是在C语言的基础上增加了一部分的面向对象的语法，将C语言复杂的、繁琐的语法封装的更为简单。OC是完全兼容C语言的。在OC中可以写任意的C代码，且效果一致。

## 与C的异同

- OC文件后缀名为`.m`而C文件后缀为`.c`

- 引入文件OC使用`#import <xxx>` 而C是 `#include <xxx>`

  - Import 是 include 的增强版，在预编译的时候将引入文件的内容拷贝到写指令的地方，同一个文件无论import多少次，只会包含1次，就像webpack ES6打包一样
  - 如果include像实现import的效果则需要条件编译指令

  ```c
  // 如果是用 include 为防止多次引入
  #ifndef test_h
  #define test_h
  #include <stdio.h>
  void sayHi();
  #endif /* test_h */
  // 如果是用 import 引入，因为import本身就防止多次引入
  void sayHi();
  ```

- OC把所有的代码都放在 `@sutoreleasepool{}`这个代码块中，这个是一个自动释放池

- 控制台打印用NSLog()函数，这个函数在foundation框架中，因此一定要引入这个框架

  - NSLog()是printf的增强版，会在printf的基础上**加一些调试信息时间、run的项目名、进程编号、线程编号**最后才是输出的信息，并且输出万信息之后会**自动换行**、**OC中新增的数据类型也只能用NSLog()输出**

- C中字符串存储方式是使用字符数组存储和使用字符指针\0位字符串结束符，而OC中有一个更为好用的用来存储字符串的数据类型 NSString

  - NSString 类型的指针变量 专门存储OC字符串的地址
  - OC字符串常量必须使用一个前缀@
    - `"jack"` C语言字符串
    - `@"jack"` OC字符串
  - NSString类型的指针变量，只能存储OC字符串的地址，因此使用方式是`NSString *str = @"jack";`，如果把C语言字符串直接付给 NSString 会直接报错

- OC的NS前缀，这就关系到这么语言的历史了，NS是NextStep的缩写，因为这些方法或者数据类型都是NextStep公司编写或者定义的。

- OC与C的注释一摸一样

- 函数的定义和调用是一样的

- 运算符和C一摸一样

- OC支持C的所有控制语句

- OC支持C关键字，也新增了一些关键字绝大多数以@开头

- 数据类型，OC中支持所有的C数据类型，以下列举一些新增的类型

  - OC字符串：NSString *str = @"test";
  - 布尔类型 BOOL： YES/NO （相对于别的语言中的 true/false）`BOOL b1 = 10 > 20;bool b2 = YES;`，定义时写 BOOL / bool 都可以
    - 本质上 bool 就是语法糖 char 的 typedef，YES/NO 就是 1/0强转为 char 的 define
  - 布尔类型 Boolean：true/false `Boolean b1 = 10>20;Boolean b2 = false;`
    - 本质上 Boolean 就是语法糖 unsigned char 的 typedef，YES/NO 就是 1/0 的 define
  - 类 class：[面向对象语法所用到的类型](#面向对象)
  - id类型 万能指针：
  - nil：与 NULL 差不多
  - SEL 方法选择器：
  - block 代码段：

因此我们在编写OC代码的时候都用`#import`方式引入，并且都用NSLog()打印信息，字符串都用OC字符串

一个简单的OC例子

```objc
#import <Foundation/Foundation.h>
// 兼容C文件
#import "test.h"
double area(double a, double b) {
    return a * b;
}
int main(int argc, const char *argv[]) {
    @autoreleasepool {
        NSLog(@"3*3=%f", area(3.0,3.0));
        int a = sayHi();
        NSLog(@"%d",a);
        NSString *str = @"test";
        NSLog(@"%@",str);
        // argc 就是第几个条件
        // 终端输入 ./ex1 -s aa
        //   argc==3 argv[0]=="./ex1" argv[1]=="-s" argv[2]=="aa"
        for (int i = 0; i< argc; i++) {
            NSLog(@"%s", argv[i]);
        }
    }
    return 0;
}
```

**编译**：可以用Xcode创建工程后直接运行，也可以用terminal编译连接执行（前提是安装了Xcode命令行工具）

```shell
# 编译，生成xx.o文件
$ cc -c xx.m
# 链接头文件，如使用到了foundation框架，生成a.out可执行文件
$ cc xx.o -framework Foundation
# 执行
$ ./a.out
```

## 面向对象

OC在C的基础上增加了一小部分的面向对象的语法

定义类的语法，直接写着源文件中，不要写着main函数中，语法：

- 类的声明

```objc
@interface 类名 : NSObject {
// 类的共同特征（属性/成员变量/字段）
  // 要想属性被外部反问则加一个@public关键字
  @public
  NSString *_name;
  int _age;
  float _weight;
}
// 类的共同行为（方法的声明）
// 无参数方法 - (返回值类型)方法名称;
// 一个参数 - (返回值类型)方法名称:(参数类型)形参名称;
// 带多个参数 - (返回值类型)方法名称:(参数类型)参数名称 :(参数类型)参数名称;
- (void)run;
- (void)eat:(NSString *)food;
- (int)sum:(int)num1 :(int)num2;
// 声明尽量写详细一点，如下面那样，这个代码规范 
- (int)sumWith:(int)num1 and:(int)num2;
@end
```

- 类的实现

```objc
@implementation 类名
// 方法的实现写在这里
- (void)run {
  //语句
  // 这里可以直接访问属性，不需要让属性公有化，方法中的属性是实例对象的属性
  _weight -= 0.5f;
  NSLog(@"running...");
}

- (void)eat:(NSString *)food {
  _weight += 0.7f;
  NSLog(@"eat %@", food);
}

- (int)sum:(int)num1 :(int)num2 {
  return num1 + num2;
}
- (int)sumWith:(int)num1 and:(int)num2 {
  return num1 + num2;
}
@end
```

类的定义中必须要有类的声明和实现，类名的每一个单词的首字母要大写，为类定义的私有属性名开头用下划线

- 类是无法直接使用的，如果要使用这个类的话，必须要先生成对象

  ```objc
  // 类名 *对象名 = [类名 new];
  Person *Leo = [Person new];
  ```

- 访问对象的属性，通常来说对象的属性是不允许外界直接访问的

  - 如果想要对象的属性允许被访问，要在声明属性时加上@public
  - 取值`对象名->属性名/(*对象名).属性名` ，赋值`对象名->属性名=值/(*对象名).属性名=值`

- 类的方法的调用

  - 无参数 `[对象名 方法名]; [s1 run];`
  - 带一个参数 `[对象名 方法名:实参]; [s1 eat:@"bat"];`
  - 带多个参数 ``[对象名 方法名:实参1 :实参2]; int sum = [s1 sum:1 :2]; int sum = [s1 sumWith:1 and:2];`

### 对象在内存中的存储

OC是兼容C的所以C的内存区域就是OC中的内存，C的内存有五大区域：栈（局部变量）、堆（程序员手动申请的字节空间 malloc calloc realloc）、BSS段（存储未被初始化的全局变量和静态变量）、数据段（常量区、存储已被存储的全局变量、静态变量和常量数据）、代码段（存储程序代码）

- 类加载

  - 创建对象的时候需要访问类的
  - 声明一个类的指针变量也会访问类

  在程序运行期间，当某个类第一次被访问到的时候，会将这个类存储到代码段区域，这个过程叫做类加载，只有类在第一次被访问的时候才会被加载，一旦类被加载到代码段以后，直到程序结束才会被释放。

- 对象在内存中究竟是如何存储

  - Person *p1 = [Person new]; 
    - 首先 Person *p1 会在栈内存中申请一块空间，在栈内存中声明一个Person类型的指针变量p1，因为p1是指针变量，所以只能是地址
    - [Person new] 真正在内存中创建对象的事这个代码，这个 new 在堆内存中申请了一块一个合适大小的空间，在这个空间中根据类的模版创建对象，类模版中定义了什么属性，就把这些属性依次声明在对象（这块空间）之中，对象中还有另外一个属性 isa指针，这个指针指向对象所属的类在代码段的地址
    - 初始化对象的属性 如果属性的类型是基本数据类型则复制为0 如果是C语言的指针类型则赋值为NULL 如果属性是OC的类指针类型则赋值为 nil 返回对象在堆中的地址，即p1指针就是对象在堆中的地址

