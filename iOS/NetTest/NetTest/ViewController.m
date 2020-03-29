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
//    NSString *str = @"{\"name\":\"xiaoming\",\"age\":12}";
    NSDictionary *dict = @{@"name": @"xiaoming", @"age": @12, @"fun":@"123"};
    NSArray *arr = @[@{@"name":@"张三"},@{@"name":@"李四"}];
    NSData *data = [NSJSONSerialization dataWithJSONObject:arr options:0 error:nil];
    [self postJSON:data];
    
}
//@"http://192.168.88.103/upload/upload.php"
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self uploadFileWithUrl:@"http://192.168.88.103/upload/upload.php" fileFieldName:@"userfile" filePath:[[NSBundle mainBundle] pathForResource:@"timg.jpeg" ofType:nil]];
}

- (void)uploadFileWithUrl:(NSString*)urlString fileFieldName:(NSString*)fieldName filePath:(NSString*)filePath{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    // 设置请求方法
    request.HTTPMethod = @"post";
    // 设置请求头
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBOUNDARY] forHTTPHeaderField:@"Content-Type"];
    // 把文件转为二进制数据
    request.HTTPBody = [self makeRequestBodyWithfileFieldName:fieldName filePath:filePath];
    
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connect error");
            return;
        }
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse*)response;
        if (httpRes.statusCode != 200 && httpRes.statusCode != 304) {
            NSLog(@"server error");
            return;
        }
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"parse error %@", error);
            return;
        }
        NSLog(@"%@",dict);
    }];
}
// 请求体格式
//--boundary
//Content-Disposition: form-data; name="userfile"; filename="timg.jpeg"
//Content-Type: image/jpeg
//
//二进制数据
//--boundary--
// 参数一：要在服务器上保存的名字 参数二：文件域的名字 参数三：文件路径
- (NSData*)makeRequestBodyWithfileFieldName:(NSString*)fileField filePath:(NSString*)path{
    NSMutableData *dataM = [NSMutableData new];
    NSMutableString *strM1 = [NSMutableString new];
    [strM1 appendFormat:@"--%@\r\n",kBOUNDARY];
    [strM1 appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileField, [path lastPathComponent]];
    [strM1 appendString:@"Content-Type: application/octet-stream\r\n\r\n"];
    [dataM appendData:[strM1 dataUsingEncoding:NSUTF8StringEncoding]];
    
    [dataM appendData:[NSData dataWithContentsOfFile:path]];
    
    NSString *end = [NSString stringWithFormat:@"\r\n--%@--",kBOUNDARY];
    [dataM appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    return dataM.copy;
}

- (void)postJSON:(NSData*)data{
    NSURL *url = [NSURL URLWithString:@"http://192.168.88.103/upload/postjson.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    // 设置请求方法
    request.HTTPMethod = @"post";
    request.HTTPBody = data;
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connect error");
            return;
        }
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse*)response;
        if (httpRes.statusCode != 200 && httpRes.statusCode != 304) {
            NSLog(@"server error");
            return;
        }
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"parse error %@", error);
            return;
        }
        NSLog(@"%@",dict);
    }];
}

@end
