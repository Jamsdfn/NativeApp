#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editBtn;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    self.editBtn.action = @selector(editClick);
    self.editBtn.target = self;
    self.nameTextField.text = self.conctact.name;
    self.phoneTextField.text = self.conctact.phoneNumber;
}

- (void)editClick{
    self.nameTextField.text = self.conctact.name;
    self.phoneTextField.text = self.conctact.phoneNumber;
    self.saveBtn.hidden ? (self.editBtn.title = @"取消") : (self.editBtn.title = @"编辑");
    self.nameTextField.enabled = !self.nameTextField.enabled;
    self.phoneTextField.enabled = !self.phoneTextField.enabled;
    self.saveBtn.hidden = !self.saveBtn.hidden;
}

- (void)save{
    self.conctact.name = self.nameTextField.text;
    self.conctact.phoneNumber = self.phoneTextField.text;
    if ([self.delegate respondsToSelector:@selector(editViewController:)]) {
        [self.delegate editViewController:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
