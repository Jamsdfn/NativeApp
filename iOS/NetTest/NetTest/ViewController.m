//
//  ViewController.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/25.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "ViewController.h"
@interface ViewController ()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloader;
@property (nonatomic, strong) NSData *resumeData;

@end

@implementation ViewController

- (NSURLSession *)session{
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)start:(id)sender {
    [self downloadTaskWithProcess];
}
- (IBAction)pause:(id)sender {
    [self.downloader cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
        // 为了防止多次点击停止，后resumeData重置为null
        self.downloader = nil;
    }];
    
}
- (IBAction)goOn:(id)sender {
    self.downloader = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.downloader resume];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self downloadTask];
//    NSLog(@"1");
//    [self downloadTaskWithProcess];
}

- (void)downloadTaskWithProcess {
    NSURLSessionDownloadTask *downloader = [self.session downloadTaskWithURL:[NSURL URLWithString:@"http://192.168.1.6/1.zip"]];
    self.downloader = downloader;
    [self.downloader resume];
}
// 开始续传的时候调用的方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    NSLog(@"续传");
}
// 获取进度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    float process = totalBytesWritten * 1.0f / totalBytesExpectedToWrite;
    NSLog(@"%f",process);
}
// 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"finish");
}


@end
