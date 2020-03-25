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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = inet_addr("192.168.88.100");
    addr.sin_port = htons(3000);
    int result = connect(clientSocket, (const struct sockaddr *) &addr, sizeof(addr));
    if (result == 0) {
        NSLog(@"ok");
    } else {
        NSLog(@"error");
    }
}


@end
