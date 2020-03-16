//
//  SettingCell.h
//  project_bet
//
//  Created by Jamsdfn on 2020/3/16.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *item;

+ (instancetype)settingCellWithTableView:(UITableView *)tableView andItem:(NSDictionary *)item;
+ (UITableViewCellStyle)loadCellStyleWithItem:(NSDictionary *)item;
@end

NS_ASSUME_NONNULL_END
