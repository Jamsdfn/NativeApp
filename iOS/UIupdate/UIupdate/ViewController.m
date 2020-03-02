#import "ViewController.h"
#import "Contry.h"
#import "ContryView.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *contries;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contries];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 80;
}

- (NSArray *)contries{
    if (!_contries) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"03flags.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arr) {
            Contry *model = [Contry contryWithDictionary:item];
            [arrM addObject:model];
        }
        _contries = arrM;
    }
    return _contries;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.contries.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    Contry *model = self.contries[row];
    ContryView *contry = [ContryView contryView];
    contry.contry = model;
    
    return contry;
    
}

@end
