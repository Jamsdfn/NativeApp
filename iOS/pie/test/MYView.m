#import "MYView.h"

@interface MYView()


@end

@implementation MYView

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150) radius:80 startAngle:0 - M_PI/2 endAngle:2 * M_PI * self.value - M_PI/2 clockwise:YES];
    [path addLineToPoint:CGPointMake(150, 150)];
    [path fill];
}

- (void)setProgressValue:(CGFloat)value{
    self.value = value;
    [self setNeedsDisplay];
}


@end
