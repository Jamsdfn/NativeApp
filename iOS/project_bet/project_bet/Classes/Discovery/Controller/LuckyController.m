//
//  LuckyController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/16.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "LuckyController.h"

@interface LuckyController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LuckyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.animationImages = @[[UIImage imageNamed:@"lucky_entry_light0"], [UIImage imageNamed:@"lucky_entry_light1"]];
    self.imageView.animationDuration = 1;
    [self.imageView startAnimating];
}


@end
