//
//  AppCell.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/23.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "AppCell.h"

@implementation AppCell

- (instancetype)initWithTableView:(UITableView *)tableView{
    static NSString *identifier = @"app_cell";
    self = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!self) {
        self = [[AppCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return self;
}

+ (instancetype)appcellWithTableView:(UITableView *)tableView{
    return [[self alloc] initWithTableView:tableView];
}

- (void)setModel:(App *)model{
    _model = model;
    self.textLabel.text = model.name;
    self.detailTextLabel.text = model.download;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
