#import "ViewController.h"
#import "CarGroup.h"
#import "Car.h"
// 遵守协议
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *groups;

@end

@implementation ViewController

// 改变状态栏的颜色
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}
// 隐藏状态栏
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}
- (NSArray *)groups{
    if (!_groups) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
        NSArray *arrDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arrDict) {
            CarGroup *model = [CarGroup carGroupWithDictionary:item];
            [arrM addObject:model];
        }
        _groups = arrM;
    }
    return _groups;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self groups];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    self.tableView.rowHeight = 60;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarGroup *group = self.groups[indexPath.section];
    Car *car = group.cars[indexPath.row];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"修改车品牌名" message:car.name preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = car.name;
        }];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
           handler:^(UIAlertAction * action) {
            car.name = alert.textFields[0].text;
            NSIndexPath *idx = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
            [tableView reloadRowsAtIndexPaths:@[idx] withRowAnimation:UITableViewRowAnimationNone];
        }];
         
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //option 这个方法如果不实现则默认为一组
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // required 每一组显示几条数据
    CarGroup *group = self.groups[section];
    return group.cars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 在创建单元格的时候指定一个重用ID
    NSString *ID = @"car_cell";
    // 当需要一个新的单元格的时候，先去观察池中根据重用ID,查找是否有可用的单元格
    // 有则使用
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        // 无则新创建
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CarGroup *groupModel = self.groups[indexPath.section];
    Car *car = groupModel.cars[indexPath.row];
    cell.textLabel.text = car.name;
    cell.imageView.image = [UIImage imageNamed:car.icon];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CarGroup *header = self.groups[section];
    return header.title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return [self.groups valueForKeyPath:@"title"];
}

@end
