//
//  DownloadManager.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/30.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "DownloadManager.h"

@interface DownloadManager()<NSURLConnectionDataDelegate>

@property (nonatomic, assign) long long expectedContentLength;
@property (nonatomic, assign) long long currentFileSize;
@property (nonatomic, strong) NSOutputStream *stream;
@property (nonatomic, copy) NSString *saveFilePath;
@property (nonatomic, strong) NSURLConnection *conn;
@property (nonatomic, copy) void (^successBlock)(NSString *path);
@property (nonatomic, copy) void (^processBlock)(float path);
@property (nonatomic, copy) void (^errorBlock)(NSError *error);
@property (nonatomic, strong) NSURL *url;

@end

@implementation DownloadManager

- (void)main{
    @autoreleasepool {
//        [NSThread sleepForTimeInterval:1];
        NSURL *url = self.url;
        [self getServerFileInfo:url];
        // 如果返回值为 -1 则表示下载完成 返回 0 则重头下载 其他值则为已下载的文件大小
        self.currentFileSize = [self checkLoaclFIleInfo];
        if (self.currentFileSize == -1) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                self.successBlock(self.saveFilePath);
            }];
            return;
        }
        [self downloadFile:url];
    }
}

- (void)pause{
    [self.conn cancel];
    // 把自己从队列中移除
    [self cancel];
}

+ (instancetype)downloader:(NSString *)urlString successBlock:(nonnull void (^)(NSString * _Nonnull))successBlock processBlock:(nonnull void (^)(float))processBlock errorBlock:(nonnull void (^)(NSError * _Nonnull))errorBlock{
    DownloadManager *downloader = [self new];
    downloader.successBlock = successBlock;
    downloader.processBlock = processBlock;
    downloader.errorBlock = errorBlock;
    downloader.url = [NSURL URLWithString:urlString];
    return downloader;
    
}

- (void)downloadFile:(NSURL*)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setValue:[NSString stringWithFormat:@"bytes=%lld-",self.currentFileSize] forHTTPHeaderField:@"Range"];
    // 这个方法是在当前线程的消息循环中下载的，所以要把他加在子线程中
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.conn = conn;
    // 因为子线程的消息循环默认是关闭的，因此在设置好下载后要开启消息循环
    [[NSRunLoop currentRunLoop] run];
}

- (void)getServerFileInfo:(NSURL*)url {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"head";
    NSURLResponse *response;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:NULL];
    self.expectedContentLength = response.expectedContentLength;
    self.saveFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:response.suggestedFilename];
}

- (long long)checkLoaclFIleInfo {
    long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 判断文件是否存在，如果文件不存在则返回零，从开始位置下载
    if ([fileManager fileExistsAtPath:self.saveFilePath]) {
        // 获取文件信息
        NSDictionary *fileInfo = [fileManager attributesOfItemAtPath:self.saveFilePath error:NULL];
        // NSFileManager给字典做了分类，所以可以直接拿到文件信息
        // 拿到当前文件大小
        fileSize = fileInfo.fileSize;
        if (fileSize == self.expectedContentLength) {
            // 已下载完成，返回-1
            return -1;
        }
        if (fileSize > self.expectedContentLength) {
            // 如果文件大小大于服务器文件大小，表明下载出错，要先删除文件后重新下载
            [fileManager removeItemAtPath:self.saveFilePath error:NULL];
            return 0;
        }
        
    }
    return fileSize;
}

//接收到响应头,开始下载
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.stream = [NSOutputStream outputStreamToFileAtPath:self.saveFilePath append:YES];
    [self.stream open];
}
//持续接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    self.currentFileSize += data.length;
    if (self.processBlock) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.processBlock(self.currentFileSize*1.0f/self.expectedContentLength);
        }];
    }
    [self.stream write:data.bytes maxLength:data.length];
    
}

//下载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"over");
    [self.stream close];
    if (self.successBlock) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.successBlock(self.saveFilePath);
        }];
    }
}

//下载出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"错误");
    if (self.errorBlock) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.errorBlock(error);
        }];
    }
}

@end
