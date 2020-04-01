//
//  ViewController.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/25.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import <WebKit/WebKit.h>
#import "ViewController.h"
#import "SSZipArchive.h"
@interface ViewController ()<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloader;
@property (nonatomic, strong) NSData *resumeData;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (NSURLSession *)session{
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        // 代理方法在主队列中执行，这样就可以方便控制UI控件
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
        // 暂停后吧数据保存进沙盒，这样用户重启app的时候就不怕数据丢失
        NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test"];
        [self.resumeData writeToFile:path atomically:YES];
        // 为了防止多次点击停止，后resumeData重置为null
        self.downloader = nil;
    }];
    
}
- (IBAction)goOn:(id)sender {
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"test"];
    [self.resumeData writeToFile:path atomically:YES];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        self.resumeData = [NSData dataWithContentsOfFile:path];
    }
    if (!self.resumeData) return;
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
    self.progressView.progress = process;
    NSLog(@"%f",process);
}
// 下载完成
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *fileInTmp = NSTemporaryDirectory();
//    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:fileInTmp error:NULL];
    // 下载好后直接帮我们解压
    [SSZipArchive unzipFileAtPath:location.path toDestination:fileInTmp uniqueId:nil];
    [SSZipArchive createZipFileAtPath:@"/Users/duzuhua/Desktop/1.zip" withContentsOfDirectory:[NSTemporaryDirectory() stringByAppendingPathComponent:@"pro"]];
    NSLog(@"finish");
}


@end
