//
//  ViewController.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/25.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "ViewController.h"
#import "Manager.h"
#import "ProcessView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ProcessView *ProcessView;
@end

@implementation ViewController
- (IBAction)Stop:(id)sender {
    [[Manager sharedManager] pause:@"http://192.168.1.6/1.zip"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ProcessView.process = 0.0f;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Manager *downloadManager = [Manager sharedManager];
    [downloadManager download:@"http://192.168.1.6/1.zip" successBlock:^(NSString * _Nonnull path) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"恭喜" message:@"下载完成" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alertController addAction:action];
//        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"ok");
    } processBlock:^(float process) {
//        NSLog(@"%f", process);
        self.ProcessView.process = process;
    } errorBlock:^(NSError * _Nonnull error) {
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"下载出现错误" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        }];
//        [alertController addAction:action];
//        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"error");
    }];
}

@end
