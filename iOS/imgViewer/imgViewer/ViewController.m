#import "ViewController.h"
#import "CarGroup.h"
// 遵守协议
@interface ViewController () <UITableViewDataSource>

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
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_simple.plist" ofType:nil];
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
    // 参数indexPath 属性 indexPath.section 表示当前是第几组 indexPath.row 表示是第几行
    // required 每一组的每一条实现怎样的单元格数据
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    CarGroup *group = self.groups[indexPath.section];
    NSString *car = group.cars[indexPath.row];
    cell.textLabel.text = car;
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 组标题显示内容
    CarGroup *group = self.groups[section];
    return group.title;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    // 组尾显示的内容
    CarGroup *group = self.groups[section];
    return group.desc;
}

@end
