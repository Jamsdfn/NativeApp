//
//  ViewController.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/25.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "ViewController.h"
#import "MResponse.h"
#import "DownloadManager.h"
#define kBOUNDARY @"myBoundary"
@interface ViewController () <NSXMLParserDelegate>

@property (nonatomic, strong) NSOperationQueue *queue;
@end

@implementation ViewController


- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//@"http://192.168.88.103/upload/upload.php"
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self getHead];
    DownloadManager *download = [DownloadManager new];
    [download download:@"http://192.168.1.6/1.zip"];
}

- (void)getHead{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.6/1.zip"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    request.HTTPMethod = @"head";
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connection error");
            return;
        }
        NSHTTPURLResponse *httpres = (NSHTTPURLResponse*)response;
        if (httpres.statusCode != 200 && httpres.statusCode != 304) {
            NSLog(@"server error");
            return;
        }
//        NSLog(@"%@", data);
//        NSLog(@"response head: %@",response);
        NSLog(@"%lld", response.expectedContentLength);
        NSLog(@"%@",response.suggestedFilename);
    }];
}

@end
