//
//  ViewController.m
//  clock
//
//  Created by Jamsdfn on 2020/3/11.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) CALayer *second;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 表盘
    CALayer *clock = [[CALayer alloc] init];
    clock.bounds = CGRectMake(0, 0, 200, 200);
    clock.position = CGPointMake(200, 200);
    clock.contents = (__bridge id)[UIImage imageNamed:@"clock"].CGImage;
    clock.cornerRadius = 100;
    clock.masksToBounds = YES;
    [self.view.layer addSublayer:clock];
    
    // 秒针
    CALayer *second = [CALayer new];
    second.bounds = CGRectMake(0, 0, 2, 90);
    second.position = clock.position;
    second.backgroundColor = [UIColor redColor].CGColor;
    // 锚点（定位点）
    second.anchorPoint = CGPointMake(0.5, 0.8);
    
    // 定时器,无法做到和屏幕同步刷新 测试发现差了一秒，主要是省略的毫秒的问题，不可能刚好整秒取到
//    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeChange)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    [self.view.layer addSublayer:second];
    self.second = second;
    // 初始化时间
    [self timeChange];
}

- (void)timeChange{
    // 一秒转动的秒数
    CGFloat angle =  2 * M_PI / 60;
    
    NSDate *date = [NSDate date];
    // 这样是可以的，也可以用cNSCalendar对象
//    NSDateFormatter *formatter = [NSDateFormatter new];
//    formatter.dateFormat = @"ss";
//    CGFloat time = [[formatter stringFromDate:date] floatValue];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    CGFloat time = [cal component:NSCalendarUnitSecond fromDate:date];
    
    self.second.affineTransform = CGAffineTransformMakeRotation(time * angle);
}

@end
