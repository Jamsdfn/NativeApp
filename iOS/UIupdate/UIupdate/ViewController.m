#import "ViewController.h"
#import "Contry.h"
#import "ContryView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *toolbar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.inputView = self.datePicker;
    self.textField.inputAccessoryView = self.toolbar;
}

- (UIDatePicker *)datePicker{
    if (!_datePicker) {
        // 不需要设置frame，它会自动占据键盘的位置
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-Hans"];
    }
    return _datePicker;
}

- (UIToolbar *)toolbar{
    if (!_toolbar) {
        _toolbar = [UIToolbar new];
        _toolbar.frame = CGRectMake(0, 0, 0, 44);
        UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelItemClick)];
        UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(confirmItemClick)];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        // 给bar加上barbuttonItem
        _toolbar.items = @[cancelItem, flexSpace, confirmItem];
        
    }
    return _toolbar;
}

- (void)cancelItemClick{
    [self.view endEditing:YES];
}

- (void)confirmItemClick{
    // 获取选中的日期
    NSDate *date = self.datePicker.date;
    // 将日期设置给文本框
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *str = [formatter stringFromDate:date];
    self.textField.text = str;
    // 关闭键盘
    [self.view endEditing:YES];
}

@end
