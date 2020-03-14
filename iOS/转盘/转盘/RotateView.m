//
//  RotateView.m
//  转盘
//
//  Created by Jamsdfn on 2020/3/14.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "RotateView.h"

@interface RotateView() <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *rotateImage;

@property (nonatomic, weak) UIButton *currentBtn;
@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation RotateView
+ (instancetype)rotateView{
    return [[NSBundle mainBundle] loadNibNamed:@"RotateView" owner:nil options:nil][0];
}
// 加载xib
- (void)awakeFromNib{
    [super awakeFromNib];
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [[UIButton alloc] init];
        // 这个tag后面用于计算，让选择的btn转到第一个
        btn.tag = i;
        [btn setImage:[self clipImageWithImage:[UIImage imageNamed:@"LuckyAstrology"] withIndex:i] forState:UIControlStateNormal];
        [btn setImage:[self clipImageWithImage:[UIImage imageNamed:@"LuckyAstrologyPressed"] withIndex:i] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        // 设置完看效果发现，图片太靠近按钮了，又要往圆心外靠一点，因此给btn的图片设置一个负的内边距，让图片往外移
        [btn setImageEdgeInsets:UIEdgeInsetsMake(-50, 0, 0, 0)];
        [self.rotateImage addSubview:btn];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
//    [self startRotate];
}

- (IBAction)pickLuckyNumber {
    if (self.currentBtn) {
        // 防止重复点
        if (![self.rotateImage.layer animationForKey:@"key"]) {
            self.link.paused = YES;
            // 用核心动画的基本动画快速选择
            CABasicAnimation *animation = [[CABasicAnimation alloc] init];
            animation.keyPath = @"transform.rotation";
            CGFloat angle = 2 * M_PI / 12 * self.currentBtn.tag;
            animation.toValue = @(5 * 2 * M_PI - angle);
            animation.duration = 2;

            animation.fillMode = kCAFillModeForwards;
            animation.removedOnCompletion = NO;
            
            [self.rotateImage.layer addAnimation:animation forKey:@"key"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 因为核心动画的旋转只是动layer层，实际的功能按钮位置是没改变的，因此这里要改一下按钮的位置
                self.rotateImage.transform = CGAffineTransformMakeRotation(- angle);
                // 删除核心动画，因为核心动画的不会到原位会把layer层固定死，不能让其重新旋转
                [self.rotateImage.layer removeAnimationForKey:@"key"];
                // 警告框
                [self alertMessageTitle:@"幸运数字" withContent:@"1 2 3 4 5" andAction:^{
                    self.link.paused = NO;
                }];
                
            });
        }
        
    } else {
        [self alertMessageTitle:@"警告" withContent:@"请选择星座" andAction:^{}];
    }
}
// 弹出消息框
- (void)alertMessageTitle:(NSString *)title withContent:(NSString *)msg andAction:(void (^)(void))callback{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        callback();
        
    }];
    [alertController addAction:action];
    // 用代理让控制器弹出警告框
    if ([self.delegate respondsToSelector:@selector(rotateView:alertWithAlertController:)]){
        [self.delegate rotateView:self alertWithAlertController:alertController];
    }
}

// 选择星座
- (void)btnClick:(UIButton *)sender{
    self.currentBtn.selected = NO;
    sender.selected = YES;
    self.currentBtn = sender;
}

// 开始旋转
- (void)startRotate{
    // cadisplaylink 大约是一秒执行60次左右，注意旋转的速度
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(rotate)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}
- (void)rotate{
    self.rotateImage.transform = CGAffineTransformRotate(self.rotateImage.transform, 2 * M_PI / 60 / 10);
}


// 开始渲染控件
- (void)layoutSubviews{
    [super layoutSubviews];
    for (int i = 0; i < self.rotateImage.subviews.count; i++) {
        UIButton *btn = self.rotateImage.subviews[i];
        btn.center = self.rotateImage.center;
        btn.bounds = CGRectMake(0, 0, 68, 143);
        // 设置锚点，锚点就是设置view的中心点位置x,y范围都是[0,1]
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        CGFloat angle = 2 * M_PI / 12;
        btn.transform = CGAffineTransformMakeRotation(angle * i);
        
    }
}

// 切割精灵图
- (UIImage *)clipImageWithImage:(UIImage *)image withIndex:(NSInteger)index{
    // 注意，因为苹果手机对图片是由缩放的，比如2x倍的缩放，显示100，但是要原图200
    CGFloat w = (image.size.width / 12) * [UIScreen mainScreen].scale;
    CGFloat h = image.size.height * [UIScreen mainScreen].scale;
    CGFloat x = index * w;
    CGFloat y = 0;
    // 切割好图片后缩放成合适的大小
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(image.CGImage, CGRectMake(x,y,w,h)) scale:2.3 orientation:UIImageOrientationUp];
}
@end
