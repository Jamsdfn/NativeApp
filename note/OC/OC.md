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

OC在C的基础上增加了一小部分的面向对象的语法，面向对象的三大特征就是：封装、继承、多态

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

**注**：声明和实现不能相互嵌套，类一定要先声明后实现，一个类声明和实现都要有，类的声明必须放在使用类的前面，实现可以放在使用类的后面，属性名异地昂要以下划线开头，类名开头要大写，这是规范。声明属性的时候不能赋值，会直接报语法错误。

除去特殊情况（只有实现没有声明），类声明和实现都要有，如

```objc
@implementation Student : NSObject
{
  NSString *_name;
}
- (void)sayHi {
  NSLog(@"test");
}
@end
// 调用
Student *s1 = [Student new];
[s1 sayHi];
// 上述代码是可以正常执行的，这样写感觉就有点像java了，虽然可以，但是在OC中极度不推荐
```

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
    - [Person new] 真正在内存中创建对象的事这个代码，这个 new 在堆内存中申请了一块一个合适大小的空间，在这个空间中根据类的模版创建对象，类模版中定义了什么属性，就把这些属性依次声明在对象（这块空间）之中，对象中还有**另外加上了一个属性 isa指针**，这个指针指向对象所属的类在代码段的地址
    - 初始化对象的属性 如果属性的类型是基本数据类型则复制为0 如果是C语言的指针类型则赋值为NULL 如果属性是OC的类指针类型则赋值为 nil 返回对象在堆中的地址，即p1指针就是对象在堆中的地址

    通过一大段的分析得，对象在内存中是只有属性（自定义的属性加isa指针），没有方法的。

  - 因为对象是哪有方法的那么对象是如何调用对象的方法的呢，其实就用到了**isa指针**，调用方法时p1指针找到堆中对象位置，然后在通过isa指针找到类在代码段中的位置，之后调用代码段中的方法

  - 那么为什么不把方法放入对象中呢，因为对象的属性是互不干扰的，所以没创建一个对象都要申请一块空间，而对象的方法是高度相同的，如果每次new都申请一块空间，那么将极大的浪费内存，因此对象方法不会放入对象（堆中的空间）中

### 方法和函数的异同

C语法的函数就叫做函数，OC类中写的方法就叫方法。

- 都是用来封装代码的，将一段代码封装在其中，表示一个相对独立的功能
- 函数和方法声明和定义的语法是不同的
- 函数和方法定义的位置是不同的
  - OC方法的声明只能写着@interface中，定义只能写在@implementation中
  - 函数声明和定义除了在函数内部和@interface的大括号（属性的地方）中，其他地方都可以写
- 函数可以直接调用，而方法必须先创建对象，用对象来调用
- 方法是属于类，而函数是独立的

**注**：就算把函数写在类中，函数也不属于类，创建的对象中也没有这个函数

### 对象和方法

对象可以作为方法的参数，对象也可以作为方法的返回值

类的本质其实是我们自定义的一个数据类型，那么什么是数据类型呢，其实数据类型就是在内存中开辟空间的一个模版。类的本质就是一个数据类型，因为对象在内存中的大小是由我们决定的，多写几个属性，对象占的空间就大一点。

正因为类的本质就是一个数据类型，所以我们可以把类作为一个方法的参数或者返回值

- 类作为方法的参数

```objc
// Person.h
#import <Foundation/Foundation.h>
#import "Dog.h"
@interface Person : NSObject {
  NSString *_name;
  int _age;
}
- (void)sayHi;
- (void)dogShout:(Dog *)dog;
@end
  
// Person.m
#import "Person.h"
@implementation Person
- (void)sayHi {
  NSLog(@"Hi");
}
- (void)dogShout:(Dog *)dog{
  // 这个Dog类里有个sayHi方法
  [dog sayHi];
}
@end
 
// main.m
#import "Person.h"
  // 因为Person.h里引入过Dog.h了，所以不用再引一边Dog.h,不过为了可维护行我们也可以加上
int main{
  Person *p1 = [Person new];
  [p1 sayHi];
  Dog *d1 = [Dog new];
  [p1 dogShout:d1];
  return 0;
}
```

- 类作为返回值

```objc
// Person.h
#import <Foundation/Foundation.h>
#import "Dog.h"
@interface Person : NSObject {
  NSString *_name;
  int _age;
}
- (void)sayHi;
- (Dog *)createDog;
@end
  
// Person.m
#import "Person.h"
@implementation Person
- (void)sayHi {
  NSLog(@"Hi");
}
- (Dog *)createDog {
	Dog *d1 = [Dog new];
  return d1;
}
@end
 
// main.m
#import "Person.h"
  // 因为Person.h里引入过Dog.h了，所以不用再引一边Dog.h,不过为了可维护行我们也可以加上
int main{
  Person *p1 = [Person new];
  [p1 sayHi];
  Dog *d1 = [p1 createDog];
  [d1 sayHi];
  return 0;
}
```

- 对象作为类的属性

引入好之后在属性中直接写就好了

- 类的实现中如何调用自身别的方法 `[self fun];`

### 类方法

OC中的方法分为两种：对象方法/实例方法和类方法。

对象方法就是必须先创建对象，通过类名来调用的方法；类方法的调用不依赖于对象，如果要调用类方法，不需要创建对象，而是直接通过类名来调用

对象方法的声明使用 - 号 如`- (void)sayHi;` 

类方法的声明使用 + 号，语法和对象方法一样；实现也是在 @implementation 中使用和对象方法也差不多 `[类名 类方法];`

类方法的特点：

- 节约空间：因为调用类方法不用创建对象
- 提高效率：因为调用类方法不需要先找对象指针再找isa指针再找到代码段中的方法，一步到位

**注**：在类方法中不能直接访问属性，也不能调用对象方法。如果方法不直接访问属性，也不调用对象方法，我们可以把方法定义为类方法，这样节约空间。如果我们写一个类，那么就要求为这个类提供一个和类名同名的类方法，这个方法一个最纯洁的对象返回。苹果和第三方都遵循这个规范。可以通过类方法给对象初始化值 `+ (void)类名With属性1:()属性 and属性2:()属性`

### 匿名对象

创建对象不赋值给对象指针，那么这个创建的对象就是匿名对象

### 对象之间的关系

主要是四种关系：组合关系、依赖关系、关联关系、继承关系

- 组合关系

  多个小的类组成一个大的类

- 依赖关系

  一个对象的方法的参数是另外一个对象，即对象作为类方法的参数，就叫依赖关系。如果是A类的 fun:(B *)classB; 那么A就依赖于B。这是高耦合的关系

- 关联关系

  简单来说就是一个类作为另外一个类的属性，但是又不是组合关系，而是一个类似于拥有的关系，那么就是关联关系

#### 类的继承



## nil 与 NULL

NULL只能作为指针变量的值，如果一个指针变量的值为NULL则代表这个指针不指向内存中的任何空间，其实NULL等价于0，但是不完全等价，他不是整型的0

nil只能作为指针变量的值代表这个指针不指向内存中的任何空间 nil完全等价于NULL

虽然两者完全等价，还是要建议一下，nil只用于OC的类指针，NULL用于C指针，如果类指针指向nil如`Person *p1 = nil;`那么如果访问对象属性则会报错，但是掉用对象方法不会报错，而是不会执行任何操作，跳过这条语句了

## NSString 常用类方法

- `+ (instancetype)stringWithUTF8String:(const char *)nullTerminatedCString;`

  - instancetype 作为返回值表示返回当前这个类的对象，作用：把C语言字符串转化为OC字符串对象

  ```objc
  char *s0 = "rose";
  NSString *s1 = [NSString stringWithUTF8String:s0];
  ```

- `+ (instancetype)stringWithFormat:(NSString *)format,... `

  - 作用：拼接字符串，使用变量或者其他数据拼接成OC字符串

  ```objc
  int age=10;
  NSSting *name=@"ming";
  NSString *s = [NSString stringWithFormat:@"大家好我叫%@,今年%d岁",name,age];
  ```

- [str length] 对象方法

  - 得到字符串长度

  ```objc
  NSString *str = @"test";
  NSUInteger len = [str length];
  NSLog(@"%lu",len); // 4
  // NSUInteger 其实就是 typedef unsigned long NSUInteger;
  ```

- [str characterAtIndex:2]

  - 得到对应位置的字符

  ```objc
  NSString *str = @"你好啊";
  unichar ch = [str characterAtIndex:2]; // 啊
  NSLog(@"第三个字符是 %C", ch);// 啊，注意这里时大写的C
  // unichar 就是一个官方定义 typedef unsigned short unichar;
  ```

- `- (BOOL)isEqualToString:(NSString *)aString;`

  - 判断两个字符串是否相等

  ```objc
  NSString *str1 = @"jack";
  NSString *str2 = [NSString stringWithFormat:@"jack"];
  if([str1 isEqualToString:str2]){
    NSLog(@"==");
  }
  // 判断不能直接用 == 判断，== 只对都是用str1的方式创建的OC字符串有效
  ```

## static 关键字

C语言中用于修饰局部变量（使变量储存在常量区函数执行完毕后变量还存在，不会被回收）、修饰全局变量、修饰函数

OC中static关键字不是修饰类属性和类方法，但可以修饰类方法中的局部变量作用和C语言一样

## 分组导航标记

其实就是Xcode的一个小技巧在类声明前加上`#pragma mark xxx的声明`，类实现前加上`#pragma mark xxx的实现`。点击编辑区域导航条main后面的tab就可在导航条上分组如图

![](./1.png)

`#pragma mark -`则会加一条分割线

`#pragma mark - x分类`则会加一条分割线，线后面紧接着加上一条分组

## 多文件开发

通常我们把一个类写在一个模块之中，一个模块至少包含两个文件，一个是.h头文件，一个是.m实现文件，在头文件中写类的声明，在实现文件中写类的实现。因为头文件中要用到 Foundation 框架中的 NSObject 类，所以 .h 文件中要引入 Foundation 框架。因为.h文件引入过框架了，所以实现文件即使用到Foundation的类也可以不引入框架。

xcode中直接新建一个 cocoa class 就可以自动生成.h .m文件，并且相关引入也会帮你引入好。

在我们写好这个模块后，如果想使用的话直接在main中引入模块的头文件就可以使用了。

```objc
// Person.h
#import <Foundation/Foundation.h>
#import "Gender.h"
@interface Person : NSObject {
  NSString *_name;
  int _age;
  Gender _gender;
}
- (void)sayHi;
@end
  
// Person.m
#import "Person.h"
@implementation Person
- (void)sayHi {
  NSLog(@"Hi");
}
@end
 
// main.m
#import "Person.h"

int main{
  Person *p1 = [Person new];
  [p1 sayHi];
  return 0;
}
// 如果我们多个类都用到了性别这个属性，我们为了提高代码的可阅读性，我们可以单独定义一个枚举的头文件，哪个类用到我们就引入就好了
// Gender.h
typedef enum {
  Male,
  Female
} Gender;

```

## OC异常处理

什么是异常：当程序在执行的时候处于某种特定调价下，程序的执行会终止。

OC有自己的异常机制@try{}@catch(NSException *ex){}，将有可能有异常的代码放入@try{}中，如果出现异常，程序不会崩溃，而会立即跳入@catch中执行catch代码，和别的语言的try...catch 是一样的。正如别的语言一样OC也可以在try...catch后加一个@finally，即无论成功失败都会执行的代码。

**注**：不是所有的运行时异常try...catch都能捕获到的，如C语言的异常是无法处理的，比如除数为0，所以用的是比较少的，避免异常的方式还是用逻辑判断。

## Xcode文档的安装





