//
//  Bgview.m
//  test
//
//  Created by Jamsdfn on 2020/3/10.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "Bgview.h"

@interface Bgview()

@property (nonatomic, strong) NSArray *images;

@end

@implementation Bgview

- (NSArray *)images{
    if (!_images) {
        _images = @[@"spark_blue",@"spark_red"];
    }
    return _images;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int i = 0;
    for (UITouch *t in touches) {
        [self addSparkWith:t andImageNamed:self.images[i]];
        i++;
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    int i = 0;
    for (UITouch *t in touches) {
        [self addSparkWith:t andImageNamed:self.images[i]];
        i++;
    }
}

- (void)addSparkWith:(UITouch *)touch andImageNamed:(NSString *)imageNamed{
    CGPoint p = [touch locationInView:self];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
    imgView.center = p;
    [self addSubview:imgView];
    [UIView animateWithDuration:2 animations:^{
        imgView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [imgView removeFromSuperview];
        }
    }];
}


@end
