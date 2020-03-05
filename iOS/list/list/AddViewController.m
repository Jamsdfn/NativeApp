#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.nameTextField addTarget:self action:@selector(textFieldsChange) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTextField addTarget:self action:@selector(textFieldsChange) forControlEvents:UIControlEventEditingChanged];
    [self.addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    // 让姓名文本框称为第一响应者，一切到添加联系人界面直接调出键盘
    [self.nameTextField becomeFirstResponder];
    
}

- (void)textFieldsChange{
    if (self.nameTextField.text.length > 0 && self.phoneTextField.text.length > 0) {
        self.addBtn.enabled = YES;
    }
}

- (void)addBtnClick{
    // block
//    if (self.addPerson){
//        self.addPerson(self.nameTextField.text, self.phoneTextField.text);
//    }
    // delegate
    if ([self.delegate respondsToSelector:@selector(addViewController:withContact:)]){
        Contact *model = [Contact new];
        model.name = self.nameTextField.text;
        model.phoneNumber = self.phoneTextField.text;
        [self.delegate addViewController:self withContact:model];
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
