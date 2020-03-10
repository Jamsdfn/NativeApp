//
//  UnlockView.m
//  手势解锁
//
//  Created by Jamsdfn on 2020/3/10.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "UnlockView.h"

#define kButtonCount 9

@interface UnlockView()

@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *lineBtns;
@property (nonatomic, assign) CGPoint currentPoint;

@end

@implementation UnlockView


- (NSArray *)btns{
    if(!_btns){
        _btns = [NSMutableArray new];
        for (int i = 0; i < kButtonCount; i++){
            UIButton *btn = [[UIButton alloc] init];
            btn.tag = i;
            [btn setUserInteractionEnabled:NO];
            btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gesture_node_normal"]];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
            [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateDisabled];
            [self addSubview:btn];
            [_btns addObject:btn];
        }
    }
    return _btns;
}

- (NSMutableArray *)lineBtns{
    if (!_lineBtns) {
        _lineBtns = [NSMutableArray new];
    }
    return _lineBtns;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = 74;
    CGFloat h = w;
    int colCount = 3;
    CGFloat margin = (self.frame.size.width - 3 * w) / 4;
    for (int i = 0; i < self.btns.count; i++) {
        CGFloat x = margin + (i % colCount) * (margin + w);
        CGFloat y = margin + (i / colCount) * (margin + h);
        [self.btns[i] setFrame:CGRectMake(x, y, w, h)];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        if (CGRectContainsPoint(btn.frame, point)){
            btn.selected = YES;
            [self.lineBtns addObject:btn];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:touch.view];
    
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        if (CGRectContainsPoint(btn.frame, point)){
            btn.selected = YES;
            if (![self.lineBtns containsObject:btn]) {
                [self.lineBtns addObject:btn];
            }
        }
    }
    self.currentPoint = point;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 松手后如过多出一个线头，应该先让线头消失
    self.currentPoint = [[self.lineBtns lastObject] center];
    [self setNeedsDisplay];
    NSMutableString *password = [NSMutableString new];
    for (UIButton *btn in self.lineBtns) {
        // 拼接密码
        [password appendFormat:@"%ld",btn.tag];
    }
//    NSLog(@"%@",password);
    // 执行密码验证的block
    if (self.passwordBlock) {
        if (self.passwordBlock(password)) {
            NSLog(@"correct");
            return;
        } else {
            NSLog(@"error");
        }
    }
    for (UIButton *btn in self.lineBtns) {
        // 如果不变回selected=NO状态会冲突
        btn.selected = NO;
        btn.enabled = NO;    }
    
    // 防止错误后提示前还可以画，提示出来前先把view禁用了
    [self setUserInteractionEnabled:NO];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self clear];
        // 重新开启交互
        [self setUserInteractionEnabled:YES];
    });
    
}
// 清空
- (void)clear{
    for (UIButton *btn in self.btns) {
        btn.selected = NO;
        btn.enabled = YES;
    }
    [self.lineBtns removeAllObjects];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    // 没有选中不用绘图
    if (!self.lineBtns.count) return;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int i = 0; i < self.lineBtns.count; i++) {
        UIButton *btn = self.lineBtns[i];
        if (i == 0) {
            // 第一个按钮为起点
            [path moveToPoint:btn.center];
        } else {
            // 其他连线
            [path addLineToPoint:btn.center];
        }
    }
    // 连线到手指的位置
    [path addLineToPoint:self.currentPoint];
    // 设置线颜色
    [[UIColor whiteColor] set];
    // 设置线宽
    [path setLineWidth:10];
    // 设置线的样式
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineJoinStyle:kCGLineJoinRound];
    // 渲染
    [path stroke];
}

@end
