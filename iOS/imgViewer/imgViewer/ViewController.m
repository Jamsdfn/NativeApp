#import "ViewController.h"
#import "Question.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *cover;
@property (nonatomic, assign) CGRect originalFrame;
@property (nonatomic, strong) NSArray *questions;
@property (nonatomic, assign) int index;
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnScore;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnIcon;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)btnNextClick;
- (IBAction)bigImg:(id)sender;
- (IBAction)btnIconClick;

@end

@implementation ViewController

// 改变状态栏的颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
// 隐藏状态栏
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = -1;
    [self next];
    
    
}

- (NSArray *)questions{
    if (!_questions) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"questions.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arr) {
            Question *model = [Question questionWithDictionary:item];
            [arrM addObject:model];
        }
        _questions = arrM;
    }
    return _questions;
}

- (IBAction)btnNextClick {
    [self next];
}

- (IBAction)bigImg:(id)sender {
    _originalFrame = self.btnIcon.frame;
    UIButton *btnCover = [UIButton new];
    btnCover.frame = self.view.bounds;
    btnCover.backgroundColor = [UIColor blackColor];
    btnCover.alpha = 0;
    [self.view addSubview:btnCover];
    self.cover = btnCover;
    // 把头像放到按钮上面，类似css的zindex调到最大
    [self.view bringSubviewToFront:self.btnIcon];
    // 放大icon
    CGFloat iconW = self.view.frame.size.width;
    CGFloat iconH = iconW;
    CGFloat iconX = 0;
    CGFloat iconY = (self.view.frame.size.height - iconH) / 2;
    
    [UIView animateWithDuration:.5 animations:^{
        btnCover.alpha = 0.6;
        self.btnIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    }];
    [btnCover addTarget:self action:@selector(smallImg) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)btnIconClick {
    if (!self.cover) {
        [self bigImg:nil];
    } else {
        [self smallImg];
    }
}

- (void)smallImg{
    [UIView animateWithDuration:.5 animations:^{
        self.btnIcon.frame = self.originalFrame;
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.cover removeFromSuperview];
            self.cover = nil;
        }
    }];
    
}


- (void)next{
    self.index++;
    Question *model = self.questions[self.index];
    self.lblIndex.text = [NSString stringWithFormat:@"%d / %ld", self.index + 1, self.questions.count];
    self.lblTitle.text = model.title;
    [self.btnIcon setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    self.btnNext.enabled = (self.index != self.questions.count - 1);
}
@end
