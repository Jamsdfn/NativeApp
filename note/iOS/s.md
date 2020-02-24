# iOS

什么是iOS这里就不介绍了，都要接触开发了，应该对系统的基本信息都挺清楚了。本篇笔记重点将记下iOS 开发过程中所涉及到的知识点。

主要开发流程和web相似，先完成view层，再实现具体功能，然后调试测试，测试完成就可以发布。

## iOS UIView

UIView所有组件的父类，组件的创建和销毁的处理是UIViewController。每一个新的界面都是一个UIView，切换界面就涉及到UIView的创建和销毁，UIView与用户的交互。

### UIViewController

UIViewController是UIView的控制器，负责创建、显示、销毁UIView；负责监听UIView内部的事件；负责处理UIView与用户的交互。

UIViewController内部有个UIView属性，就是它负责管理的UIView对象 ：

@property(nonatomic,retain) UIView *view;

**UIView与UIViewController的关系**

- UIView只负责对数据的展示，采集用户的输入、监听用户的事件等。

- 其他的操作比如：每个UIView的创建、销毁、用户触发某个事件后的事件处理程序等这些都交给UIViewController来处理。

创建完组件后，先编写好功能，在把组件关联上代码就可以了，关联过程

```objc
#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtNum1;
@property (weak, nonatomic) IBOutlet UITextField *txtNum2;
@property (weak, nonatomic) IBOutlet UILabel *sum;
- (IBAction)compute;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)compute {
    NSLog(@"");
    // 获取用户的输入
    NSString *num1 = self.txtNum1.text;
    NSString *num2 = self.txtNum2.text;
    
    // 处理
    int n1 = [num1 intValue];
    int n2 = num2.intValue;
    int res = n1 + n2;
    // 显示在label上
    self.sum.text = [NSString stringWithFormat:@"%d",res];
    // 收回输入键盘
  	// 法一：谁交出键盘谁就是第一响应者，让第一响应者 resign 就可以让键盘收回去
    //[self.txtNum1 resignFirstResponder];
    //[self.txtNum2 resignFirstResponder];
    // 法二：让当前控制器控制的组件全部停止编辑，那么键盘也就会跟着收回了
  	[self.view endEditing:YES];
}
@end

```

![](./1.png)

关联后对应地方会发生改变，如果想取消关联，字节点击触发事件类型后面的×就好了

注意：要用到的控件都要关联上。

- 关联的返回值IBAction、属性类型IBOutlet，这样才能做到关联view的控件

控件的位置大小相关的属性：frame（CGRect）、center（CGPoint）、bounds（CGRect）；因此center只能控制位置（坐标原点为中心，为frame的坐标原点为左上角），虽然bounds他是个CGRect但是他的CGPoint始终是零，是无效的，因此bounds只能控制大小，以中心点放大（frame放大坐标点是左上角）。

#### 简单动画

```objc
// 法一：头尾式
- (IBAction)scale:(UIButton *)sender {
  // 开启一个动画
  	[UIView beginAnimations:nil context:nil];
  // 定义动画持续时间
    [UIView setAnimationDuration:.5];
  // =======要执行动画的方法========
    CGRect bounds = self.img.bounds;
    if (sender.tag == 4) {
        bounds.size.width += 10;
        bounds.size.height += 10;
    } else {
        bounds.size.width -= 10;
        bounds.size.height -= 10;
    }
    self.img.frame = bounds;
  // 提交方法
  [UIView commitAnimations];
}
// 法二：block式
- (IBAction)scale:(UIButton *)sender {
    CGRect frame = self.img.frame;
    if (sender.tag == 4) {
        frame.size.width += 100;
        frame.size.height += 100;
    } else {
        frame.size.width -= 100;
        frame.size.height -= 100;
    }
    [UIView animateWithDuration:1 animations:^{
        self.img.frame = frame;
    }];
}
```

#### 动态创建控件

```objc
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
// 当要显示一个界面的时候，首先创建这个界面对应的控制器
// 控制器创建好以后，接着创建控制器所管理的那个view，当这个view加载完毕后就开始执行下面的方法了
// 所以只要viewDidLoad方法被执行了，就表示控制器所管理的view创建好了
- (void)viewDidLoad {
    [super viewDidLoad];
    // web开发熟悉的感觉，比storyboard舒服多了，能用键盘操作的绝不用鼠标
  	// 创建一个纯净的按钮 如果想创建系统默认的按钮 [UIButton buttonWithType:UIButtonTypeSystem]
    UIButton *btn = [UIButton new];
    // 设置按钮上的属性
    [btn setTitle:@"点我吧" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"你点个锤子" forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
    CGRect frame;
    frame.origin = CGPointMake(50, 50);
    frame.size = CGSizeMake(96, 96);
    btn.frame = frame;
    UIImage *imgNormal = [UIImage imageNamed:@"btn_01"];
    [btn setBackgroundImage:imgNormal forState:UIControlStateNormal];
    UIImage *imgHighLight = [UIImage imageNamed:@"btn_02"];
    [btn setBackgroundImage:imgHighLight forState:UIControlStateHighlighted];
  	// 添加点击事件
  	[btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    // 把按钮加到UIView中
    [self.view addSubview:btn];
}
- (void)btnClick{
    NSLog(@"我说了，点我干嘛？");
}
@end
```

Tips:程序启动的时候出现的界面（一打开app放logo或者广告的那个界面）可以在LaunchScreen.storyboard上面画；Assets.xcassets 通常放媒体资源

#### transform属性

transform可以进行平移、缩放、旋转

```objc
- (IBAction)move {
    // 一次性平移（每次移动都是以原本坐标移动）
    self.btnIcon.transform = CGAffineTransformMakeTranslate(0, 50);
    // 可以多次平移（每一次移动都是基于上一次移动后的坐标）
    self.btnIcon.transform = CGAffineTransformTranslate(self.btnIcon.transform, 0, 50);
}

- (IBAction)rotate {
  	// 一次性
    self.btnIcon.transform = CGAffineTransformMakeRotate(M_PI/4);
    // 可以多次
    self.btnIcon.transform = CGAffineTransformRotate(self.btnIcon.transform, M_PI_4);
    
}

- (IBAction)scale {
  	// 一次性
  	self.btnIcon.transform = CGAffineTransformMakeScale(1.5, 1.5);
  	// 多次
    self.btnIcon.transform = CGAffineTransformScale(self.btnIcon.transform,1.5, 1.5);
}
- (IBAction)goBack {
  	// 复原，无论transform了多少次直接恢复到最原始的状态
    self.btnIcon.transform = CGAffineTransformIdentity;
}
```

**获取所有控件的子控件**：`self.view.subviews` 返回值为NSArray

**获取父控件**：假设一个控件为txt，这个组件也引入到了ViewController中了 `self.txt.superview`就得到了父控件了。

**不引入Controller的状况下获取控件**：想给控件设置一个tag `UITextField *txt = (UITextField *)[self.view viewWithTag:0];` 就得到tag为0的控件了，返回值就是次tag所对应的类，最好强转一下类型。但是不好维护，因为tag只能是数字

**销毁一个控件**：`[txt removeFromSuperview]`调用方法就销毁了

