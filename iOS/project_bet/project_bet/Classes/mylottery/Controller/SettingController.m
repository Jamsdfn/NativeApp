//
//  SettingController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/16.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "SettingController.h"
#import "RedeemController.h"
#import "SettingCell.h"
#import "HelpWebController.h"
@interface SettingController ()
@property (nonatomic, strong) NSArray *groups;

@end

@implementation SettingController


- (NSArray *)groups{
    if (!_groups) {
        NSString *path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:nil];
        _groups = [NSArray arrayWithContentsOfFile:path];
//        NSLog(@"%@", _groups);
    }
    return _groups;
}

- (NSString *)plistName{
    if (!_plistName) {
        _plistName = @"Settings.plist";
    }
    return _plistName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self groups];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    self.navigationItem.leftBarButtonItem = item;
    UIBarButtonItem *help = [[UIBarButtonItem alloc] initWithTitle:@"常见问题" style:UIBarButtonItemStylePlain target:self action:@selector(helpClick)];
    self.navigationItem.rightBarButtonItem = help;
}

- (void)helpClick{
    HelpWebController *webVC = [HelpWebController new];
    [self.navigationController pushViewController:webVC animated:YES];
}

- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSDictionary *rowsItem = self.groups[section];
    NSArray *items= rowsItem[@"items"];
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *group = self.groups[indexPath.section];
    NSArray *items = group[@"items"];
    NSDictionary *item = items[indexPath.row];
    SettingCell *cell = [SettingCell settingCellWithTableView:tableView andItem:item];
    cell.item = item;
    return cell;
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary *group = self.groups[section];
    return group[@"header"];
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSDictionary *group = self.groups[section];
    return group[@"footer"];
}
// 点击cell后调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *group = self.groups[indexPath.section];
    NSArray *items = group[@"items"];
    NSDictionary *item = items[indexPath.row];
    // 设置导航栏的title
    if (item[@"targetVcName"] && [item[@"targetVcName"] length] > 0){
        UIViewController *vc = [NSClassFromString(item[@"targetVcName"]) new];
        vc.navigationItem.title = item[@"title"];
        if ([vc isKindOfClass:[SettingController class]]) {
            SettingController *reuseVc = (SettingController*)vc;
            reuseVc.plistName = item[@"plistName"];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (item[@"funcName"] && [item[@"funcName"] length] > 0) {
        if ([self respondsToSelector:NSSelectorFromString(item[@"funcName"])]){
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self performSelector:NSSelectorFromString(item[@"funcName"])];
            #pragma clang diagnostic pop
        }
    }
}

- (void)checkUpdate{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"版本检测" message:@"您的应用已是最新版本" preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

// 重写init方法，因为都是重用代码，用的都要是分组
- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}
// 因为这个控制器的重用代码的plist都是组所以不管你怎么设置都变成组类型
- (instancetype)initWithStyle:(UITableViewStyle)style{
    return [super initWithStyle:UITableViewStyleGrouped];
}

@end
