//
//  WebViewController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/18.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(void)loadView{
    self.view = [[WKWebView alloc] initWithFrame:KScreenSize];
//    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = (WKWebView *)self.view;
//    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.help.html withExtension:nil];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [webView loadRequest:req];
    NSString *jsCode = [NSString stringWithFormat:@"window.onload = function(){document.location.href = '#%@';}",self.help.identifier];
    [webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable rest, NSError * _Nullable error) {}];
    
}


@end
