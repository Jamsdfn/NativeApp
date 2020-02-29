#import "TableViewController.h"
#import "App.h"
#import "AppCell.h"
@interface TableViewController ()

@property (nonatomic, strong)NSArray *apps;

@end

@implementation TableViewController

-(NSArray *)apps{
    if (!_apps) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"apps_full.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arr) {
            App *model = [App appWithDictionary:item];
            [arrM addObject:model];
        }
        _apps = arrM;
    }
    return _apps;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self apps];
    self.tableView.rowHeight = 70;
//    NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    App *model = self.apps[indexPath.row];
    NSString *ID = @"app_cell";
    AppCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.app = model;
    return cell;
}


@end
