//
//  AboutController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "AboutController.h"
#import "AboutHeaderView.h"
@interface AboutController ()

@end

@implementation AboutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = [AboutHeaderView aboutHeaderView];
}


@end
