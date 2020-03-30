//
//  DownloadManager.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/30.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "DownloadManager.h"

@interface DownloadManager()

@property (nonatomic, assign) long long expectedContentLength;
@property (nonatomic, assign) NSUInteger currentFileSize;
@property (nonatomic, strong) NSOutputStream *stream;
//@property (nonatomic, strong) NSMutableData *dataM;

@end

@implementation DownloadManager



- (void)download:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        [data writeToFile:@"/Users/duzuhua/Desktop/1.zip" atomically:YES];
//        NSLog(@"ok");
//    }];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    [conn start];
    
}
//接收到响应头
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
  //通过响应头获取文件的大小
    NSLog(@"%lld",response.expectedContentLength);
    self.expectedContentLength = response.expectedContentLength;
    self.stream = [NSOutputStream outputStreamToFileAtPath:@"/Users/duzuhua/Desktop/1.zip" append:YES];
    [self.stream open];
}
//持续接收数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    self.currentFileSize += data.length;
    NSLog(@"%f",self.currentFileSize*1.0f/self.expectedContentLength);
    [self saveMethod2:data];
    
}

- (void)saveMethod1:(NSData*)data{
    NSString *filePath = @"/Users/duzuhua/Desktop/1.zip";
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (fileHandle == nil) {
        // 如果文件不存在则创建文件
        [data writeToFile:filePath atomically:YES];
    } else {
        // 把文件指针直到文件的末尾
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:data];
        [fileHandle closeFile];
    }
}

- (void)saveMethod2:(NSData*)data{
    [self.stream write:data.bytes maxLength:data.length];
}

//下载完成
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
  NSLog(@"over");
    [self.stream close];
}

//下载出错
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
  NSLog(@"错误");
}

@end
