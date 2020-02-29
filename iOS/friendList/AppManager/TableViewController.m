#import "TableViewController.h"
#import "Friend.h"
#import "Group.h"
#import "FriendCell.h"
#import "GroupHeaderView.h"
@interface TableViewController () <GroupHeaderViewDelegate>

@property (nonatomic, strong) NSArray *groups;

@end

@implementation TableViewController
// 协议方法，刷新数据
- (void)reload:(GroupHeaderView *)groupHeaderView{
//    [self.tableView reloadData];
    NSIndexSet *setion = [NSIndexSet indexSetWithIndex:groupHeaderView.tag];
    [self.tableView reloadSections:setion withRowAnimation:UITableViewRowAnimationFade];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = 44;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSArray *)groups{
    if (!_groups) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arr) {
            Group *model = [Group groupWithDictionary:item];
            [arrM addObject:model];
        }
        _groups = arrM;
    }
    
    return _groups;
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    Group *group = self.groups[section];
    NSInteger rows = 0;
    if (group.isVisible) {
        rows = group.friends.count;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Group *group = self.groups[indexPath.section];
    Friend *model  = group.friends[indexPath.row];
    
    NSString *ID = @"friend_cell";
    FriendCell *cell = [FriendCell friendCellWithTableView:tableView andIdentifier:ID];
    cell.friendModel = model;
    
    
    return cell;
}

// 设置组标题View
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 为了实现重用，不要直接返回一个UIView，返回一个UITableViewHeaderFooterView（或其子类），这个类可以重用
    Group *group = self.groups[section];
    NSString *ID = @"Group_header_view";
    GroupHeaderView *headerView = [GroupHeaderView groupHeaderViewWithtableView:tableView andIdentifier:ID];
    headerView.group = group;
    // 加一个tag，用于标记到底点击了哪一个组
    headerView.tag = section;
    headerView.delegate = self;
    return headerView;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
