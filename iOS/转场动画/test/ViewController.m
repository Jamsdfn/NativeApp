#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic, assign) NSInteger imageName;

@end

@implementation ViewController

- (IBAction)imageChange:(UISwipeGestureRecognizer *)sender {
    // 创建转场动画
    CATransition *animation = [CATransition new];
    // 设置你要做怎样的转场动画
    animation.type = @"cube";
    
    if(sender.direction == UISwipeGestureRecognizerDirectionRight) {
        if (self.imageName == 5) {
            self.imageName = 0;
        }
        self.imageName++;
        // 设置转场动画的方向
        animation.subtype = kCATransitionFromLeft;
    } else {
        if (self.imageName == 1){
            self.imageName = 6;
        }
        self.imageName--;
        // 设置转场动画的方向
        animation.subtype = kCATransitionFromRight;
    }
    self.imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld", self.imageName]];
    // 添加动画到layer
    [self.imgView.layer addAnimation:animation forKey:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgView.userInteractionEnabled = YES;
    self.imageName = 1;
}


@end
