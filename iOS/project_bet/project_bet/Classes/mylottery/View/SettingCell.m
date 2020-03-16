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
    static NSString *cellid = @"settins_cell";
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
        self.textLabel.text = item[@"title"];
        // 根据字符串生成对象
        NSString *accessoryType = item[@"accessory"];
        self.accessoryView = [NSClassFromString(accessoryType) new];
        if ([self.accessoryView isMemberOfClass:[UIImageView class]]) {
            UIImage *arrow = [UIImage imageNamed:item[@"accessoryImage"]];
            UIImageView *imageView = (UIImageView *)self.accessoryView;
            // uaccessoryView 本来就有一个位置，所以直接设置宽高就好了, 也可以赋值图片后根据图片大小sizetofit
    //        imageView.frame = CGRectMake(0, 0, arrow.size.width, arrow.size.height);
            imageView.image = arrow;
            [imageView sizeToFit];
            
        }
}

@end
