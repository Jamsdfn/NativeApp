//
//  LiveScorePushController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "LiveScorePushController.h"
#import "UIView+Frame.h"
@interface LiveScorePushController ()

@property (nonatomic, weak) UIDatePicker *datePicker;

@end

@implementation LiveScorePushController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return;
    // 不要设置frame，因为这个textfield只是为了让datePicker关联上cell而已，不用显示的
    UITextField *text = [[UITextField alloc] init];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView addSubview:text];
    
    // 创建datePicker
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    // 设置中文
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 时间格式
    datePicker.datePickerMode = UIDatePickerModeTime;
    // 设置文本框 inputView
    text.inputView = datePicker;
    self.datePicker = datePicker;
    // 创建toolbar，设置inputAccessoryView
    UIToolbar *toolbar = [[UIToolbar alloc] init];
//        toolbar.frame = CGRectMake(0, 0, 0, 44); 因为自己写了个分类，设置高度就可以不用这样写了
    toolbar.h = 44;
    toolbar.w = KScreenWidth;
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *confirm = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmBtnClick)];
    toolbar.items = @[cancel, flexItem, confirm];
    
    text.inputAccessoryView = toolbar;
    // 让文本框称为第一响应者
    [text becomeFirstResponder];
}
- (void)cancelBtnClick{
    [self.view endEditing:YES];
}

- (void)confirmBtnClick{
    NSDate *date = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSString *time = [formatter stringFromDate:date];
    // 获取选中的 cell 的 indexPath
    NSIndexPath *idx = [self.tableView indexPathForSelectedRow];
    // 通过 indexPath 获得当前选中的 cell
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:idx];
    cell.detailTextLabel.text = time;
    [self.view endEditing:YES];
}

@end
