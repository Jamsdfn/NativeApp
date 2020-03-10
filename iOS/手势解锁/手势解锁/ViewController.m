//
//  ViewController.m
//  手势解锁
//
//  Created by Jamsdfn on 2020/3/10.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ViewController.h"
#import "UnlockView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UnlockView *passwordView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    NSString *rightPassword = @"012";
    
    self.passwordView.passwordBlock = ^(NSString *password) {
        if ([password isEqualToString:rightPassword]) {
            return YES;
        }else{
            return NO;
        }
    };
    
}


@end
