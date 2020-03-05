#import "LoginController.h"
#import "SVProgressHUD.h"
#import "ContactViewController.h"
@interface LoginController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UISwitch *remPasswordSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.usernameTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    // 监听登录按钮
    [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.remPasswordSwitch addTarget:self action:@selector(rememberPassword) forControlEvents:UIControlEventValueChanged];
    [self.autoLoginSwitch addTarget:self action:@selector(autoLogin) forControlEvents:UIControlEventValueChanged];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.remPasswordSwitch.on = [ud boolForKey:@"isRemPassword"];
    self.autoLoginSwitch.on = [ud boolForKey:@"isAutoLogin"];
    self.usernameTextField.text = [ud objectForKey:@"username"];
    if (self.remPasswordSwitch.isOn) {
        self.passwordTextField.text = [ud objectForKey:@"password"];
    }
    [self textChange];
    if (self.autoLoginSwitch.isOn) {
        [self login];
    }
}

- (void)rememberPassword{
    if (!self.remPasswordSwitch.isOn){
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

- (void)autoLogin{
    if (self.autoLoginSwitch.isOn){
        [self.remPasswordSwitch setOn:YES animated:YES];
    }
}

- (void)login{
    // 提示正在登陆
    [SVProgressHUD showWithStatus:@"正在登陆" maskType:SVProgressHUDMaskTypeBlack];
    // 模拟服务器延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if(!([self.usernameTextField.text isEqualToString:@"a"] && [self.passwordTextField.text isEqualToString:@"a"])) {
            [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
            return;
        }
        // 保存 preference 的状态
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setBool:self.remPasswordSwitch.isOn forKey:@"isRemPassword"];
        [ud setBool:self.autoLoginSwitch.isOn forKey:@"isAutoLogin"];
        if (self.remPasswordSwitch.isOn) {
            [ud setObject:self.usernameTextField.text forKey:@"username"];
            [ud setObject:self.passwordTextField.text forKey:@"password"];
        }
        [ud synchronize];
        [self performSegueWithIdentifier:@"login2contact" sender:nil];
        
    });
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ContactViewController *contact = segue.destinationViewController;
    contact.username = self.usernameTextField.text;
}

- (void)textChange{
    if (self.usernameTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        self.loginButton.enabled = YES;
    } else {
        self.loginButton.enabled = NO;
    }
}


@end
