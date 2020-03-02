#import "ViewController.h"
#import "City.h"
@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, strong) NSArray *provinces;
@property (weak, nonatomic) IBOutlet UILabel *province;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) City *selectedProvince;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
//    [self pickerView:self.pickerView didSelectRow:0 inComponent:0];
   }

- (NSArray *)provinces{
    if (!_provinces) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"02cities.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arr) {
            City *province = [City cityWithDictionary:item];
            [arrM addObject:province];
        }
        _provinces = arrM;
    }
    return _provinces;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return self.provinces.count;
    } else {
        // 先获取第一个组的数据，才能确定这一组的数据（二级联动）
        NSInteger selectedProvince = [pickerView selectedRowInComponent:0];
        // 第一组和第二组数据在滚动的时候都会调用titleForRow这个方法，如果这里不把数据保存下来的话，第二组滚动的时候回频繁的创建一个新的对象，然后在这个新的对象中调用的row是旧的那个row，因此有可能会出现数组越界的错误。
        self.selectedProvince = self.provinces[selectedProvince];
        return self.selectedProvince.cities.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        City *province = self.provinces[row];
        return province.name;
    } else {
        // 用保存的数据，无论你第一组动的时候怎么调用这个方法也row也不会越界
        return self.selectedProvince.cities[row];
    }
}

// 滚动第一组要刷新数据
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        [pickerView reloadComponent:1];
        // 为了防止第二组原本停在一个位置，这个位置本身就超越了第一组数据中的数组范围。因为reload本身只是刷新数据,已选位置是不会改变的，因此要把一算位置改成第一行
        [pickerView selectRow:0 inComponent:1 animated:NO];
    }
    NSInteger selCity = [pickerView selectedRowInComponent:1];
    self.province.text = self.selectedProvince.name;
    self.city.text = self.selectedProvince.cities[selCity];
}



@end
