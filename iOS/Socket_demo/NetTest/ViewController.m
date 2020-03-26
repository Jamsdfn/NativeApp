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

@interface ViewController ()
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, assign) int clientSocket;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.queue = [NSOperationQueue new];
    // GET / HTTP/1.1\r\n
    // Host: www.baidu.com\r\n\r\n
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    BOOL res = [self connect:@"192.168.88.100" port:3000];
    if (!res) {
        return;
    }
    NSString *recMsg = [self sendAndRecv:@"GET / HTTP/1.1\r\n"
    "Host: www.baidu.com\r\n"
    "Connection: close\r\n\r\n"];
    close(self.clientSocket);
    NSRange range = [recMsg rangeOfString:@"\r\n\r\n"];
    NSString *html = [recMsg substringFromIndex:range.location+range.length];
    WKWebView *webview = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [webview loadHTMLString:html baseURL:[NSURL URLWithString:@"http://192.168.88.100:3000"]];
    [self.view addSubview:webview];
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
