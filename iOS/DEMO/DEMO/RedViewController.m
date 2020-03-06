#import "RedViewController.h"
#import "GreenViewController.h"
@interface RedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabBarItem.title = @"联系人";
    self.tabBarItem.badgeValue = @"1";
}
- (IBAction)go2Green:(UIButton *)sender {
    // 创建一个绿色控制器
    GreenViewController *greenvc = [GreenViewController new];
    // 跳转
    [self.navigationController pushViewController:greenvc animated:YES];
    
    
    
}



@end
