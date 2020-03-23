//
//  ViewController.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/20.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController


- (NSOperationQueue *)queue{
    if(!_queue){
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)start:(UIButton *)sender {
    
    if (!self.queue.operationCount) {
        [self.queue addOperationWithBlock:^{
             [self random];
        }];
        self.queue.suspended = NO;
        [sender setTitle:@"stop" forState:UIControlStateNormal];
    } else if (!self.queue.isSuspended){
        self.queue.suspended = YES;
        [sender setTitle:@"start" forState:UIControlStateNormal];
    }
}

// 随机生成三个数字，显示到label
- (void)random {
    while(!self.queue.isSuspended){
        [NSThread sleepForTimeInterval:0.05];
        int num1 = arc4random_uniform(10);// [0,10)
        int num2 = arc4random_uniform(10);
        int num3 = arc4random_uniform(10);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.lbl1.text = [NSString stringWithFormat:@"%d", num1];
            self.lbl2.text = [NSString stringWithFormat:@"%d", num2];
            self.lbl3.text = [NSString stringWithFormat:@"%d", num3];
        }];
    }
}

@end
