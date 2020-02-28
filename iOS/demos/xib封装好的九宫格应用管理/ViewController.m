#import "ViewController.h"
#import "App.h"
#import "AppView.h"
@interface ViewController ()

@property (nonatomic, strong) NSArray *apps;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self apps];
    int colmuns = 3;
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat marginTop = 30;
    
    for (int i = 0; i < self.apps.count; i++) {
        App *item = self.apps[i];
        int col = i % 3;
        int row = i / 3;
        
        AppView *appView = [AppView appView];
        CGFloat marginX = (viewWidth - colmuns * appView.frame.size.width)/(colmuns + 1);
        CGFloat marginY = marginX;
        CGFloat appX = marginX + col * (appView.frame.size.width + marginX);
        CGFloat appY = marginTop + row * (appView.frame.size.height  + marginY);
        appView.frame = CGRectMake(appX, appY, appView.frame.size.width, appView.frame.size.height);
        [self.view addSubview:appView];
        appView.model = item;
        
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
