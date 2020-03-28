//
//  ViewController.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/25.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import <WebKit/WebKit.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import "ViewController.h"
#import "MResponse.h"
#import "GDataXMLNode.h"
#import "NSString+Hash.h"
@interface ViewController () <NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *passoword;

@property (weak, nonatomic) IBOutlet UISwitch *isRemember;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, assign) int clientSocket;
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) MResponse *currentVideo;
@property (nonatomic, copy) NSMutableString *mStr;

@end

@implementation ViewController

- (NSMutableArray *)videos {
    if (!_videos) {
        _videos = [NSMutableArray new];
    }
    return _videos;
}

- (NSMutableString *)mStr{
    if (!_mStr) {
        _mStr = [NSMutableString new];
    }
    return _mStr;
}

- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRemember.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"isRemember"];
    if (self.isRemember.isOn) {
        self.username.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        self.passoword.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    }
    [self.isRemember addTarget:self action:@selector(isRememberSwitchChange) forControlEvents:UIControlEventValueChanged];
    [self performSelector:@selector(login:) withObject:nil];
}
- (void)isRememberSwitchChange{
    [[NSUserDefaults standardUserDefaults] setBool:self.isRemember.isOn forKey:@"isRemember"];
}
- (IBAction)login:(id)sender {
    NSString *username = self.username.text;
    NSString *password = self.passoword.text;
    [self loginWithUserName:username password:password];
}

- (void)loginWithUserName:(NSString*)username password:(NSString*)password{
    NSString *strUrl = @"http://192.168.88.100/login/login.php";
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:15];
    request.HTTPMethod = @"post";
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
    // 要把查询字符串转化为二进制数据（NSData）
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connection error");
            return;
        }
        NSHTTPURLResponse *httpRes = (NSHTTPURLResponse*)response;
        if (httpRes.statusCode != 200 && httpRes.statusCode != 304) {
            NSLog(@"service error");
            return ;
        }
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSString *msg = @"登录失败";
            if ([dict[@"userId"] intValue] != -1) {
                msg = @"登录成功";
                if (self.isRemember) {
                    [self rememberWithUsername:username password:password];
                }
            }
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }];
}

- (void)rememberWithUsername:(NSString*)username password:(NSString*)password {
    if (self.isRemember.isOn) {
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    }
}

- (NSString*)base64Encode:(NSString*)str {
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString*)base64Decode:(NSString*)str {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end
