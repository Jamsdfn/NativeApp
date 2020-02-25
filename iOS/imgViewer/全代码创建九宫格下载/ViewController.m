#import "ViewController.h"
#import "App.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *apps;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self apps];
    int colmuns = 3;
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat appW = 75;
    CGFloat appH = 90;
    CGFloat marginTop = 30;
    CGFloat marginX = (viewWidth - colmuns * appW)/(colmuns + 1);
    CGFloat marginY = marginX;
    for (int i = 0; i < self.apps.count; i++) {
        App *item = self.apps[i];
        int col = i % 3;
        int row = i / 3;
        // 创建存放应用图片信息按钮的容器
        UIView *appView = [UIView new];
//        appView.backgroundColor = [UIColor blueColor];
        CGFloat appX = marginX + col * (appW + marginX);
        CGFloat appY = marginTop + row * (appH + marginY);
        appView.frame = CGRectMake(appX, appY, appW, appH);
        [self.view addSubview:appView];
        
        // 创建子控件，放进容器中
        UIImageView *imgViewIcon = [UIImageView new];
//        imgViewIcon.backgroundColor = [UIColor yellowColor];
        CGFloat iconW = 45;
        CGFloat iconH = 45;
        CGFloat iconX = (appView.frame.size.width - iconW) / 2;
        CGFloat iconY = 0;
        imgViewIcon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        // 设置图片框的图片
        UIImage *img = [UIImage imageNamed:item.icon];
        imgViewIcon.image = img;
        [appView addSubview:imgViewIcon];
        
        // 文字
        UILabel *lblName = [UILabel new];
//        lblName.backgroundColor = [UIColor whiteColor];
        CGFloat lblNameW = appView.frame.size.width;
        CGFloat lblNameH = 20;
        CGFloat lblNameX = 0;
        CGFloat lblNameY = iconH;
        lblName.frame = CGRectMake(lblNameX, lblNameY, lblNameW, lblNameH);
        lblName.text = item.name;
        lblName.textAlignment = NSTextAlignmentCenter;
        lblName.font = [UIFont systemFontOfSize:12];
        [appView addSubview:lblName];
        
        // 按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor greenColor];
        CGFloat btnW = iconW;
        CGFloat btnH = 20;
        CGFloat btnX = (appView.frame.size.width - btnW) / 2;
        CGFloat btnY = iconH + lblNameH;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:@"下载" forState:UIControlStateNormal];
        [btn setTitle:@"已安装" forState:UIControlStateDisabled];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"buttongreen"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"buttongreen_highlighted"] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn addTarget:self action:@selector(btnDownloadClick) forControlEvents:UIControlEventTouchUpInside];
        [appView addSubview:btn];
        
    }
    
}

- (void)btnDownloadClick{
    NSLog(@"下载按钮被点击了");
}

- (NSArray *)apps{
    if (!_apps) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrModels = [NSMutableArray array];
        for (NSDictionary *item in arr) {
            App *model = [App appWithDictionary:item];
            [arrModels addObject:model];
        }
        _apps = arrModels;
    }
    return _apps;
}

@end
