#import "ContactViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"
@interface ContactViewController ()<AddViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contacts];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ 的通讯录",self.username];
    
    // 添加左上角注销按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logOut)];
    self.navigationItem.leftBarButtonItem = item;
    // 分割线长度，这样写就是宽度沾满屏幕，设置上下是没用的，只会有左右的生效（上左下右）
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (NSMutableArray *)contacts{
    if (!_contacts) {
        _contacts = [NSMutableArray new];
    }
    return _contacts;
}

- (void)logOut{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"是否确定注销" preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* logoutAction = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:logoutAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UIViewController *vc = segue.destinationViewController;
    if ([vc isMemberOfClass:[AddViewController class]]){
        AddViewController *add = (AddViewController*)vc;
            // block
        //    add.addPerson = ^(NSString* name,NSString* phoneNumber) {
        //        self.navigationItem.title = name;
        //    };
            add.delegate = self;
    } else {
        EditViewController *edit = (EditViewController*)vc;
        NSIndexPath *idxPath = [self.tableView indexPathForSelectedRow];
        Contact *model = self.contacts[idxPath.row];
        edit.conctact = model;
        edit.tableView = self.tableView;
    }
    
}

- (void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contactInfo{
    [self.contacts addObject:contactInfo];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Contact *model = self.contacts[indexPath.row];
    static NSString *ID = @"contact_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.phoneNumber;
    return cell;
}


@end
