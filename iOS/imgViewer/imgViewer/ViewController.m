#import "ViewController.h"
#import "Question.h"
// 遵守协议
@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;


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
    // 设置轮播图
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
    // 设置轮播图的点
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPage = 0;
    // 创建定时器控件, 1秒执行一次，可重复执行
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    // 为了防止因为某些控件的操作影响滚动操作的线程(比如UITextView)，因此要把timer的优先级设置的和控件一样高
    // 先获取当前的消息循环对象
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)scrollImage{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages - 1) {
        page = 0;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.pageControl.currentPage = page;
        return;
    } else {
        page++;
    }
    self.pageControl.currentPage = page;
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 清除计数器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    // 重新设置计数器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(scrollImage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX = offsetX + scrollView.frame.size.width / 3;
    // 滚动过半就显示下一页
    self.pageControl.currentPage = (int)(offsetX / scrollView.frame.size.width);
}


@end
