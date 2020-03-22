//
//  ViewController.m
//  ThreadTest
//
//  Created by Jamsdfn on 2020/3/20.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ViewController.h"
#import <pthread.h>
#import "Single.h"
@interface ViewController ()
{
    dispatch_queue_t _queue;
}

@property (nonatomic, strong) NSMutableArray *photoList;


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 1000; i++) {
        [self test:i];
    }
}

- (NSMutableArray *)photoList{
    if (!_photoList) {
        _photoList = [[NSMutableArray alloc] init];
    }
    return _photoList;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%zd", self.photoList.count);
}

- (void)test:(int)index{
    dispatch_async(_queue, ^{
        NSString *filename = [NSString stringWithFormat:@"%02d.jpg",index % 10 + 1];
        NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        NSLog(@"%@ %@",[NSThread currentThread], filename);
        UIImage *img = [UIImage imageWithContentsOfFile:path];
        dispatch_barrier_async(self->_queue, ^{
            [self.photoList addObject:img];
            NSLog(@"下载完成 %@", filename);
        });
    });
    
}
- (void)show{
}
@end
