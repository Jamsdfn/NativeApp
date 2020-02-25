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
@property (weak, nonatomic) IBOutlet UIView *optionsView;
@property (weak, nonatomic) IBOutlet UIView *answerView;


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
-  (void)loadImgWithModel:(Question *)model andIndex:(int)index{
    self.lblIndex.text = [NSString stringWithFormat:@"%d / %ld", index + 1, self.questions.count];
    self.lblTitle.text = model.title;
    [self.btnIcon setImage:[UIImage imageNamed:model.icon] forState:UIControlStateNormal];
    self.btnNext.enabled = (index != self.questions.count - 1);
}

- (void)loadAnswerBtnWithModel:(Question *)model{
    NSUInteger len = model.answer.length;
    // 按钮frame的一些定值
    CGFloat answerW = 35;
    CGFloat answerH = 35;
    CGFloat answerY = 0;
    CGFloat margin = 10;
    CGFloat baseX = (self.answerView.frame.size.width - (len * (answerW + margin) - margin)) / 2;
    for (int i = 0; i < len; i++) {
        UIButton *btnAnswer = [UIButton new];
        // 设置按钮背景图
        [btnAnswer setBackgroundImage:[UIImage imageNamed:@"btn_answer"] forState:UIControlStateNormal];
        [btnAnswer setBackgroundImage:[UIImage imageNamed:@"btn_answer_highlighted"] forState:UIControlStateHighlighted];
        // 设置frame
        CGFloat answerX = baseX + (margin + answerW) * i;
        btnAnswer.frame = CGRectMake(answerX, answerY, answerW, answerH);
        self.answerView.backgroundColor = [UIColor clearColor];
        // 添加到指定区域
        [self.answerView addSubview:btnAnswer];
    }
}

- (void)loadOptionsBtnWithModel:(Question *)model{
    // 清除上一次按钮
    [self.optionsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 获取待选文字数组
    NSArray *words = model.options;
    // 生成按钮
    // 按钮frame的定值
    int colmus = 7;
    CGFloat optionW = 35;
    CGFloat optionH = 35;
    CGFloat baseY = 0;
    CGFloat margin = 10;
    CGFloat baseX = (self.answerView.frame.size.width - (colmus * (optionW + margin) - margin)) / 2;
    for (int i = 0; i < words.count; i++) {
        int col = i % colmus;
        int row = i / colmus;
        UIButton *btnOption= [UIButton new];
        
        [btnOption setBackgroundImage:[UIImage imageNamed:@"btn_option"] forState:UIControlStateNormal];
        [btnOption setBackgroundImage:[UIImage imageNamed:@"btn_option_hignlighted"] forState:UIControlStateHighlighted];
        [btnOption setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnOption setTitle:words[i] forState:UIControlStateNormal];
        CGFloat optionX = baseX + col * (margin + optionW);
        CGFloat optionY = baseY + row * (margin + optionH);
        btnOption.frame = CGRectMake(optionX, optionY, optionW, optionH);
        self.optionsView.backgroundColor = [UIColor clearColor];
        [self.optionsView addSubview:btnOption];
        
        
    }
}
    
- (void)next{
    self.index++;
    Question *model = self.questions[self.index];
    [self loadImgWithModel:model andIndex:self.index];
    // 清除之前的答案按钮
//    while (self.answerView.subviews.firstObject) {
//        [self.answerView.subviews.firstObject removeFromSuperview];
//    }
    [self.answerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 动态创建答案按钮
    [self loadAnswerBtnWithModel:model];
    // 动态创建选项按钮
    [self loadOptionsBtnWithModel:model];
}
@end
