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
@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, assign) int clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.queue = [NSOperationQueue new];
    // 获取网络数据的第一个方式
    NSURL *url = [NSURL URLWithString:@"http://192.168.88.100/aaa/demo.json"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 设置缓存策略，和连接延时（超时后不管服务器断不断开连接，客户端都断开）
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            NSLog(@"connect error");
            return;
        }
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        if (httpResponse.statusCode != 200 && httpResponse.statusCode != 304) {
            NSLog(@"server error");
            return;
        }
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            NSLog(@"JSONparse error: %@",error);
            return;
        }
//        NSLog(@"%@",dict);
        MResponse *msg = [MResponse messageWithDictionary:dict];
        NSLog(@"%@,%@",msg.messageId,msg.message);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (BOOL)connect:(NSString *)ip port:(int)port{
    int clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    self.clientSocket = clientSocket;
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr(ip.UTF8String);
    addr.sin_port = htons(port);
    int result = connect(clientSocket, (const struct sockaddr *) &addr, sizeof(addr));
    if (result) {
        return NO;
    }
    return YES;
}

- (NSString *)sendAndRecv:(NSString *)msg{
    const char *m = msg.UTF8String;
    ssize_t sendCount = send(self.clientSocket,m,strlen(m),0);
    NSLog(@"%zd",sendCount);
    uint8_t buffer[1024];
    ssize_t recvCount = -1;
    NSMutableData *mData = [NSMutableData new];
    do {
        recvCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
        if (recvCount) {
            [mData appendBytes:buffer length:recvCount];
        }
    }while(recvCount != 0);
    NSString *res = [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding];
    return res;
}

@end