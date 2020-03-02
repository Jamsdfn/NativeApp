#import "ViewController.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblFruit;
@property (weak, nonatomic) IBOutlet UILabel *lblMainDish;
@property (weak, nonatomic) IBOutlet UILabel *lblDrink;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)randomOrderBtnClick;

@property (nonatomic, strong) NSArray *foods;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self foods];
    [self pickerView:self.pickerView didSelectRow:NSNotFound inComponent:NSNotFound];
}

- (IBAction)randomOrderBtnClick {
    for (int i = 0; i < self.foods.count; i++) {
        // 生产随机数
        int random = arc4random_uniform((unsigned int)[self.foods[i] count]);
        // pickerView选中
        [self.pickerView selectRow:random inComponent:i animated:YES];
        // lbl 选中
        [self pickerView:self.pickerView didSelectRow:random inComponent:i];
        
    }
}
#pragma mark - 懒加载



- (NSArray *)foods{
    if (!_foods) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"01foods.plist" ofType:nil];
        _foods = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _foods;
}
#pragma mark - pickerView设置
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.foods.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.foods[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.foods[component][row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
            self.lblFruit.text = self.foods[component][row];
            break;
        case 1:
            self.lblMainDish.text = self.foods[component][row];
            break;
        case 2:
            self.lblDrink.text = self.foods[component][row];
            break;
        default:
            self.lblDrink.text = @"请选择酒水";
            self.lblMainDish.text = @"请选择主菜";
            self.lblFruit.text = @"请选择水果";
            break;
    }
}


@end
