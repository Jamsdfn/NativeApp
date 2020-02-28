#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblindex;
@property (nonatomic, strong) NSArray *pic;
@property (nonatomic, assign) int index;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnForward;

- (IBAction)forward;

- (IBAction)next;

- (void)showImgWith:(int)index andCount:(unsigned long)count;


@end

@implementation ViewController

- (NSArray *)pic {
    if (_pic == nil) {
        // 在app根路径下搜索pic.plist 得到路径返回给path
        NSString *path = [[NSBundle mainBundle] pathForResource:@"pic.plist" ofType:nil];
        // 读取文件
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        _pic = arr;
    }
    return _pic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pic];
    [self showImgWith:self.index andCount:self.pic.count];
    
}


- (IBAction)forward {
    self.index--;
    [self showImgWith:self.index andCount:self.pic.count];
}

- (IBAction)next {
    self.index++;
    [self showImgWith:self.index andCount:self.pic.count];
}

- (void)showImgWith:(int)index andCount:(unsigned long)count{
    NSDictionary *item =  self.pic[index];
    self.lblindex.text = [NSString stringWithFormat:@"%d / %ld", index + 1, count];
    self.imgViewIcon.image = [UIImage imageNamed: item[@"icon"]];
    self.lblTitle.text = item[@"title"];
    if (index == count - 1) {
        self.btnNext.enabled = NO;
    } else if (index == 0) {
        self.btnForward.enabled = NO;
    } else {
        self.btnForward.enabled =  YES;
        self.btnNext.enabled = YES;
    }
}
@end
