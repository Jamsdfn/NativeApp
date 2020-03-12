#import "ViewController.h"

@interface Bgview : UIView

@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end;

@end

@implementation Bgview

- (void)drawRect:(CGRect)rect{
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:self.start];
    [path addLineToPoint:self.end];
    [path stroke];
    
}

@end


@interface ViewController ()<UICollisionBehaviorDelegate>

@property (nonatomic, weak) UIView *redView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIAttachmentBehavior *attach;
@property (nonatomic, strong) NSMutableArray *bodys;

@end

@implementation ViewController
// 动画者对象懒加载
- (UIDynamicAnimator *)animator{
    if (!_animator){
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}

- (NSMutableArray *)bodys{
    if (!_bodys){
        _bodys = [NSMutableArray new];
    }
    return _bodys;
}

- (void)loadView{
    self.view = [Bgview new];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 9; i++) {
        UIView *wormView = [[UIView alloc] init];
        CGFloat w = 30;
        CGFloat h = w;
        CGFloat x = i * w + 30;
        CGFloat y = 100;
        wormView.frame = CGRectMake(x, y, w, h);
        wormView.backgroundColor = [UIColor redColor];
        if (i == 8) {
            y = y-h/2;
            w *= 2;
            h *= 2;
            wormView.frame = CGRectMake(x, y, w, h);
            wormView.backgroundColor = [UIColor blueColor];
            // 添加一个拖拽手势
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
            [wormView addGestureRecognizer:pan];
        }
        wormView.layer.cornerRadius = w/2;
        wormView.layer.masksToBounds = YES;
        [self.view addSubview:wormView];
        [self.bodys addObject:wormView];
    }
    for (int i = 0; i < self.bodys.count - 1; i++) {
        UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc] initWithItem:self.bodys[i] attachedToItem:self.bodys[i+1]];
        [self.animator addBehavior:attach];
    }
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:self.bodys];
    [self.animator addBehavior:gravity];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:self.bodys];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
}

-(void)pan:(UIPanGestureRecognizer*)sender{
    CGPoint p = [sender locationInView:self.view];
    if (!self.attach){
        UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc] initWithItem:sender.view attachedToAnchor:p];
        self.attach = attach;
    }
    
    self.attach.anchorPoint = p;
    
    [self.animator addBehavior:self.attach];
    // 松手的时候取消attach
    if (sender.state == UIGestureRecognizerStateEnded){
        [self.animator removeBehavior:self.attach];
    }
}


@end
