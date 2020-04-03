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
#import "AFHTTPSessionManager.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIProgressView *pView;
@property (nonatomic, strong) NSURLSession *session;

@end

@implementation ViewController

//controller遵守代理NSURLSessionDataDelegate
- (NSURLSession *)session{
    if (_session == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.HTTPAdditionalHeaders = @{@"Authorization": [self getAuthorizationValueWithuser:@"admin" pwd:@"123456"]};
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(0,credential);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self deleteFile];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://192.168.1.6/aaa/demo.json" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
    } failure:nil];
}

- (void)deleteFile{
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.6/uploads/Information.pdf"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"delete";
    [request setValue:[self getAuthorizationValueWithuser:@"admin" pwd:@"123456"] forHTTPHeaderField:@"Authorization"];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"删除成功%@",str);
        NSLog(@"%@",response);
    }] resume];
}

- (NSString*)getAuthorizationValueWithuser:(NSString*)name pwd:(NSString*)pwd{
    NSString *value = [self base64Encode:[NSString stringWithFormat:@"%@:%@", name, pwd]];
    return [NSString stringWithFormat:@"Basic %@",value];
}

- (NSString*)base64Encode:(NSString*)str{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

@end
