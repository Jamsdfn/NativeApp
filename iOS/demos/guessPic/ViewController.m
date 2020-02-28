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
- (IBAction)btnTipClick;

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

- (IBAction)btnTipClick {
    // 减分
    [self addScore:-1000];
    // 清空答案按钮，即每个答案按钮点击一下
    for(UIButton *answer in self.answerView.subviews) {
        [self answerBtnClick:answer];
    }
    // 根据所有从数据中找到答案的第一个字，匹配到option按钮，模拟按键点击
    Question *model = self.questions[self.index];
    NSString *tipChar = [model.answer substringWithRange:NSMakeRange(0, 1)];
    for(UIButton *option in self.optionsView.subviews) {
        if ([option.currentTitle isEqualToString:tipChar]) {
            [self optionBtnClick:option];
        }
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
        [btnAnswer setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 添加到指定区域
        [self.answerView addSubview:btnAnswer];
        [btnAnswer addTarget:self action:@selector(answerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)answerBtnClick:(UIButton *)sender {
    self.optionsView.userInteractionEnabled = YES;
    [self setAnswerBtnColor:[UIColor blackColor]];
    for (UIButton *option in self.optionsView.subviews) {
        // 不能用相同的字判段，如果选项中有相同的字的话就会有bug
        if (sender.tag == option.tag) {
            option.hidden = NO;
            break;
        }
    }
    
    [sender setTitle:nil forState:UIControlStateNormal];
    
    
    
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
        // 床架唯一标识，用于答案按钮相对
        btnOption.tag = i;
        [self.optionsView addSubview:btnOption];
        // 给单选按钮注册单机事件
        // 写个带sender参数的方法
        [btnOption addTarget:self action:@selector(optionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}
// 这个sender参数的意思是，谁触发的事件，sender就是谁，有点像js的event参数
- (void)optionBtnClick:(UIButton *)sender{
    sender.hidden = YES;
    // 获取指定状态下的文字
//    NSString *text = [sender titleForState:UIControlStateNormal];
    // 获取当前状态下的文字
    NSString *text = sender.currentTitle;
    // 遍历答案按钮，在第一个不为空的地方天上选项
    BOOL isFull = YES;
    for (UIButton *answer in self.answerView.subviews){
        if (!answer.currentTitle) {
            [answer setTitle:text forState:UIControlStateNormal];
            // 答案与选项按钮相对于
            answer.tag = sender.tag;
            break;
        }
    }
    // 为了防止点填满后选项按钮还能点，做两个for循环，也尝试过最后在隐藏，但是按钮按下的效果还有
    // 判断答案按钮是否已满，满了optionsView直接停止交互
    NSMutableString *answerStr = [NSMutableString new];
    for (UIButton *answer in self.answerView.subviews){
        if (!answer.currentTitle) {
            isFull = NO;
            break;
        } else {
            [answerStr appendString:answer.currentTitle];
        }
    }
    if (isFull) {
        self.optionsView.userInteractionEnabled = NO;
        Question *model = self.questions[self.index];
        // 如果答案填满就判断答案
        if ([answerStr isEqualToString:model.answer]){
            // 1. 正确，文字变蓝等.5秒后跳转到下一题，加分
            [self setAnswerBtnColor:[UIColor blueColor]];
            [self addScore:100];
            [self performSelector:@selector(next) withObject:nil afterDelay:.5];
            
        } else {
            // 2. 错误，文字变红
            [self setAnswerBtnColor:[UIColor redColor]];
        }
        
    }
}



- (void) addScore:(int)score {
    int currentScore = self.btnScore.currentTitle.intValue;
    currentScore = currentScore + score;
    [self.btnScore setTitle:[NSString stringWithFormat:@"%d",currentScore] forState:UIControlStateNormal];
}
    
- (void)setAnswerBtnColor:(UIColor *)color{
    for (UIButton *answer in self.answerView.subviews) {
        [answer setTitleColor:color forState:UIControlStateNormal];
    }
}

- (void)next{
    self.optionsView.userInteractionEnabled = YES;
    self.index++;
    if (self.index == self.questions.count){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已没有下一题，请等待更新" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            self.index = -1;
            [self next];
        }];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
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
