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
@interface ViewController () <NSXMLParserDelegate>

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.queue = [NSOperationQueue new];
    // 获取网络数据的第一个方式
    NSURL *url = [NSURL URLWithString:@"http://192.168.88.100/aaa/videos.xml"];
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
        NSError *error;
        GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data error:&error];
        GDataXMLElement *rootElement = document.rootElement;
        NSMutableArray *arrM = [NSMutableArray new];
        for (GDataXMLElement *ele in rootElement.children) {
            MResponse *v = [MResponse new];
            [arrM addObject:v];
            // 给对象的属性赋值
            // 遍历子标签
            for (GDataXMLElement *subEle in ele.children) {
                //subEle.name 标签的名字 subEle.stringValue就是标签的内容
                [v setValue:subEle.stringValue forKey:subEle.name];
            }
            // 遍历属性
            for (GDataXMLNode *attr in ele.attributes) {
                [v setValue:attr.stringValue forKey:attr.name];
            }
        }
        if (error) {
            NSLog(@"xmlparse error: %@",error);
            return;
        }
        NSLog(@"%@", arrM);
//        NSLog(@"%@",arr);
//        MResponse *msg = [MResponse messageWithDictionary:dict];
    }];
    
}
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    // 开始解析文档
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    // 找开始节点(包括节点的属性)
    // elementName 节点名称
    // attributeDict 节点标签
    if ([elementName isEqualToString:@"video"]) {
        self.currentVideo = [[MResponse alloc] init];
        self.currentVideo.videoId = @([attributeDict[@"videoId"] intValue]);
        [self.videos addObject:self.currentVideo];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    // 找节点之间的内容
    [self.mStr appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    // 找结束节点
    if (![elementName isEqualToString:@"video"] && ![elementName isEqualToString:@"videos"]) {
        [self.currentVideo setValue:self.mStr forKey:elementName];
    }
    [self.mStr setString:@""];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
    // 结束解析文档
    NSLog(@"%@",self.videos);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    // 解析出错
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
