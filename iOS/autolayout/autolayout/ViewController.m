#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) NSLayoutConstraint *test;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建蓝色view
    UIView *blue = [UIView new];
    blue.backgroundColor = [UIColor blueColor];
    // 创建红色veiw
    UIView *red = [UIView new];
    red.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:blue];
    [self.view addSubview:red];
    // 禁用autoresizing
    blue.translatesAutoresizingMaskIntoConstraints = NO;
    red.translatesAutoresizingMaskIntoConstraints = NO;
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    // 创建并添加约束
    // 一个对象 的 某属性 怎么 另外一个对象 的 某属性 乘以多少倍 加上多少
    NSLayoutConstraint *blueHC = [NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    [blue addConstraint:blueHC];
    NSLayoutConstraint *blueLC = [NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:blue.superview attribute:NSLayoutAttributeLeft multiplier:1 constant:30];
    [self.view addConstraint:blueLC];
    NSLayoutConstraint *blueRC = [NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blue.superview attribute:NSLayoutAttributeRight multiplier:1 constant:-30];
    [self.view addConstraint:blueRC];
    // 相对于safeArea
    NSLayoutConstraint *blueTC = [NSLayoutConstraint constraintWithItem:blue attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view.safeAreaLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:30];
    [self.view addConstraint:blueTC];
    self.test = blueTC;
    NSLayoutConstraint *redHC = [NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeWidth multiplier:0.5 constant:0];
    [self.view addConstraint:redHC];
    
    NSLayoutConstraint *redWC = [NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    [self.view addConstraint:redWC];
    
    NSLayoutConstraint *redTC = [NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    [self.view addConstraint:redTC];
    NSLayoutConstraint *redRC = [NSLayoutConstraint constraintWithItem:red attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:blue attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    [self.view addConstraint:redRC];
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"btn" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0,500, 100, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnclick{
    self.test.constant += 100;
    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

@end
