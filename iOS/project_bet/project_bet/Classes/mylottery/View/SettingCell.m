//
//  SettingCell.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/16.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

+ (instancetype)settingCellWithTableView:(UITableView *)tableView andItem:(NSDictionary *)item;{
    // 因为cell的类型不确定，如果不同的类型用同一个复用id重用的cell就会出问题，所以id不能写死
//    static NSString *cellid = @"settins_cell";
    NSString *cellid = @"settings_cell";
    if (item[@"cellStyle"] && [item[@"cellStyle"] length] > 0) {
        cellid = item[@"cellStyle"];
    }
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[SettingCell alloc] initWithStyle:[self loadCellStyleWithItem:item] reuseIdentifier:cellid];
    }
    return cell;
}

// 根据字典返回cell类型
+ (UITableViewCellStyle)loadCellStyleWithItem:(NSDictionary *)item{
    if (item[@"cellStyle"] && [item[@"cellStyle"] isEqualToString:@"UITableViewCellStyleSubtitle"]){
        return UITableViewCellStyleSubtitle;
    } else if (item[@"cellStyle"] && [item[@"cellStyle"] isEqualToString:@"UITableViewCellStyleValue1"]) {
        return UITableViewCellStyleValue1;
    } else if (item[@"cellStyle"] && [item[@"cellStyle"] isEqualToString:@"UITableViewCellStyleValue2"]) {
        return UITableViewCellStyleValue2;
    }
    return UITableViewCellStyleDefault;
}

- (void)setItem:(NSDictionary *)item{
    _item = item;
    if (item[@"icon"]){
        self.imageView.image = [UIImage imageNamed:item[@"icon"]];
    }
    if (item[@"details"] && [item[@"details"] length] > 0) {
        self.detailTextLabel.text = item[@"details"];
    }
    if (item[@"isHighlighted"] && [item[@"isHighlighted"] boolValue]) {
        self.detailTextLabel.textColor = [UIColor redColor];
    }
    self.textLabel.text = item[@"title"];
    // 根据字符串生成对象
    NSString *accessoryType = item[@"accessory"];
    self.accessoryView = [NSClassFromString(accessoryType) new];
    if ([self.accessoryView isKindOfClass:[UIImageView class]]) {
        UIImage *arrow = [UIImage imageNamed:item[@"accessoryImage"]];
        UIImageView *imageView = (UIImageView *)self.accessoryView;
        // uaccessoryView 本来就有一个位置，所以直接设置宽高就好了, 也可以赋值图片后根据图片大小sizetofit
//        imageView.frame = CGRectMake(0, 0, arrow.size.width, arrow.size.height);
        imageView.image = arrow;
        [imageView sizeToFit];
        
    } else if ([self.accessoryView isKindOfClass:[UISwitch class]]) {
        UISwitch *switcher = (UISwitch *)self.accessoryView;
        switcher.on = [[NSUserDefaults standardUserDefaults] boolForKey:item[@"keyName"]];
        [switcher addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    }
}

- (void)switchChange:(UISwitch *)sender{
    NSString *keyName = self.item[@"keyName"];
    // 偏好设置
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:keyName];
}

@end
