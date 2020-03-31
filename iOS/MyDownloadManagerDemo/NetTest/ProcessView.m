//
//  ProcessView.m
//  NetTest
//
//  Created by Jamsdfn on 2020/3/31.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ProcessView.h"

@implementation ProcessView

-(void)setProcess:(float)process{
    _process = process;
    [self setTitle:[NSString stringWithFormat:@"%.2f%%",process * 100] forState:UIControlStateNormal];
    // 重绘
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    CGFloat radius = MIN(center.x, center.y) - 5;
    CGFloat startAngle = -M_PI/2;
    CGFloat endAngle = 2*M_PI*self.process - M_PI/2;
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    path.lineWidth = 5;
    path.lineCapStyle = kCGLineCapRound;
    [[UIColor orangeColor] setStroke];
    [path stroke];
}

@end
