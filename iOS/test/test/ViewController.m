#import "ViewController.h"
@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //每一个手势识别器的用法都差不多，比如UITapGestureRecognizer的使用步骤如下
    //创建手势识别器对象
    UILongPressGestureRecognizer *lp = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];

    

    //添加手势识别器到对应的view上
    [self.view addGestureRecognizer:lp];

    //监听手势的触发
    


   
}

- (void)tap:(UITapGestureRecognizer *)sender{
    NSLog(@"ok");
    sender.state == 
    
}
@end
