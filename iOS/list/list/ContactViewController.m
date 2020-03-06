#import "ContactViewController.h"
#import "AddViewController.h"
#import "EditViewController.h"
@interface ContactViewController ()<AddViewControllerDelegate, EditViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *contacts;
@property (strong, nonatomic) NSData *archivedData;

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
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    // 文件名字+路径,名字后缀什么的可以随便去，只要和系统文件不冲突就型
    NSString *filePath = [docPath stringByAppendingPathComponent:@"contacts.data"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *err = [NSError new];
    NSSet *set = [[NSSet alloc] initWithObjects:[Contact class],[NSMutableArray class], nil];
    self.contacts = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data error:&err];
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
        edit.delegate = self;
    }
    
}
- (void)editViewController:(EditViewController *)editViewController{
    [self.tableView reloadData];
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    // 文件名字+路径,名字后缀什么的可以随便去，只要和系统文件不冲突就型
    NSString *filePath = [docPath stringByAppendingPathComponent:@"contacts.data"];
     
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:YES error:nil];
    [data writeToFile:filePath atomically:YES];
}

- (void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contactInfo{
    [self.contacts addObject:contactInfo];
    [self.tableView reloadData];
    // 获取 documents 文件夹路径
   NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
   // 文件名字+路径,名字后缀什么的可以随便去，只要和系统文件不冲突就型
   NSString *filePath = [docPath stringByAppendingPathComponent:@"contacts.data"];
    
   NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.contacts requiringSecureCoding:YES error:nil];
   [data writeToFile:filePath atomically:YES];
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

// 让 tableView 进入编辑模式，系统给我们家的左滑出现删除按钮。这个方式就是点击按钮后的点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.contacts removeObject:self.contacts[indexPath.row]];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}

@end
