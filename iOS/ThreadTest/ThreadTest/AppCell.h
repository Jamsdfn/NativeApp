//
//  AppCell.h
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/23.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "App.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppCell : UITableViewCell
@property (nonatomic, strong) App *model;
- (instancetype)initWithTableView:(UITableView*)tableView;
+ (instancetype)appcellWithTableView:(UITableView*)tableView;
@end

NS_ASSUME_NONNULL_END
