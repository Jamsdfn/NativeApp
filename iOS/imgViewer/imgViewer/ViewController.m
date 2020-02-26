#import "ViewController.h"
#import "Question.h"
// 遵守协议
@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;



@end

@implementation ViewController

// 改变状态栏的颜色
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}
// 隐藏状态栏
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    CGFloat imgH = 162.5;
    CGFloat imgW = 375;
    CGFloat imgY = 0;
    for (int i = 0; i < 5; i++) {
        UIImageView *imgView = [UIImageView new];
        CGFloat imgX = i * imgW;
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"img_%02d",i + 1]];
        [self.scrollView addSubview:imgView];
    }
    self.scrollView.contentSize = CGSizeMake(imgW * 5, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX = offsetX + scrollView.frame.size.width / 2;
    // 滚动过半就显示下一页
    self.pageControl.currentPage = (int)(offsetX / scrollView.frame.size.width);
}


@end
