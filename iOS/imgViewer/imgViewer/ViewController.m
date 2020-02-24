#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewCat;

- (IBAction)drink;
@property (nonatomic) NSDictionary *imgInfo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    
}
- (void)setup{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tom.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.imgInfo = dict;
}

- (IBAction)drink {
    // 如果前一个动画没执行完就不执行下一个动画
    if (self.imgViewCat.isAnimating){
        return;
    }
    // 动态加载一个图片到一个NSArray中
    NSNumber *imgInfo = self.imgInfo[@"drink"];
    int imgCount = imgInfo.intValue;
    
    NSMutableArray *arrM = [NSMutableArray new];
    for (int i = 0; i < imgCount; i++) {
        // 通过这种方式加载图片h，加载好的图片会一直存放在内存中，不会释放，如果多图的话就很占内存
        // %02d 表示保留两位，如果不足两位则补零
        //UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"drink_%02d.jpg", i]];
        NSString *imgName = [NSString stringWithFormat:@"drink_%02d.jpg",i];
        NSString *path = [[NSBundle mainBundle] pathForResource:imgName ofType:nil];
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        [arrM addObject:img];
    }
    // 设置UIImageView 的animationImages属性
    self.imgViewCat.animationImages = arrM;
    // 设置动画持续时间
    self.imgViewCat.animationDuration = (self.imgViewCat.animationImages.count / 24);
    // 重复播放多少次
    self.imgViewCat.animationRepeatCount = 1;
    // 开始
    [self.imgViewCat startAnimating];
    // 释放内存
    [self.imgViewCat performSelector:@selector(setAnimationImages:) withObject:nil afterDelay:(self.imgViewCat.animationImages.count / 24)];
    
    
}
@end
