//
//  HelpWebController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/18.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "HelpWebController.h"
#import "Help.h"
#import "WebViewController.h"
#import "NavigationController.h"
@interface HelpWebController ()

@property (nonatomic, strong) NSArray *helps;

@end

@implementation HelpWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self helps];
}

- (NSArray *)helps{
    if (!_helps) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *helps = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in helps) {
            Help *model = [Help helpWithDictionary:item];
            [arrM addObject:model];
        }
        _helps = arrM;
    }
    return _helps;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.helps.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Help *model = self.helps[indexPath.row];
    static NSString *identifier = @"help_cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = model.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 用modal弹出webviewController，并且给其包装上navigation
    WebViewController *webview = [WebViewController new];
    NavigationController *vc = [[NavigationController alloc] initWithRootViewController:webview];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClick)];
    webview.navigationItem.leftBarButtonItem = cancelItem;
    webview.help = self.helps[indexPath.row];
    vc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:^{}];
}

- (void)cancelClick{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
