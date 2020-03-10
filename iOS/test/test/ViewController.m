#import "ViewController.h"
@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //每一个手势识别器的用法都差不多，比如UITapGestureRecognizer的使用步骤如下
    //创建手势识别器对象
    CALayer *layer = [CALayer new];
//    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.contents = (__bridge id)[UIImage imageNamed:@"me"].CGImage;
    layer.position = CGPointMake(200,200);
    layer.bounds = CGRectMake(0,0,100,100);
    // 记得要添加layer
    [self.view.layer addSublayer:layer];
    self.layer = layer;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.layer.transform = CATransform3DTranslate(self.layer.transform, 10, 10, 10);
}

@end
