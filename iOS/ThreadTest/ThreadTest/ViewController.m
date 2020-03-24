//
//  ViewController.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/20.
//  Copyright © 2020 Alexander. All rights reserved.
//
#import "ViewController.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSURL *url = [NSURL URLWithString:@"http://img.daimg.com/uploads/allimg/200316/3-200316000503.jpg"];
    [self.imageView sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"%ld/%ld", receivedSize,expectedSize);
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.imageView.image = image;
        NSLog(@"下完了");
    }];
}



@end
