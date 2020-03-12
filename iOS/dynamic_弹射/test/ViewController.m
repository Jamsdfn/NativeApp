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

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, assign) CGPoint areaPoint;
@property (nonatomic, weak) UIView *pig;
@end

@implementation ViewController
// 动画者对象懒加载
- (UIDynamicAnimator *)animator{
    if (!_animator){
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animator;
}


- (void)loadView{
    self.view = [Bgview new];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *bird = [UIView new];
    bird.frame = CGRectMake(150, 250, 30, 30);
    bird.backgroundColor = [UIColor redColor];
    [self.view addSubview:bird];
    self.areaPoint = bird.center;
    UIView *pig = [UIView new];
    pig.frame = CGRectMake(600, 330, 30, 30);
    pig.backgroundColor = [UIColor blueColor];
    [self.view addSubview:pig];
    self.pig = pig;
    
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[pig]];
    item.anchored = YES;
    [self.animator addBehavior:item];
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[pig, bird]];
    collision.collisionDelegate = self;
//    collision.translatesReferenceBoundsIntoBoundary = YES;
    [self.animator addBehavior:collision];
    
    // 添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [bird addGestureRecognizer:pan];
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p{
    self.pig.backgroundColor = [UIColor yellowColor];
    
}



- (void)pan:(UIPanGestureRecognizer*)sender{
    CGPoint currentPoint = [sender locationInView:self.view];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.areaPoint.x, self.areaPoint.y, 100, 0, 2*M_PI, 1);
    // 判断一个点是否在一个路径中，不在的话直接return
    if(!CGPathContainsPoint(path, NULL, currentPoint, NO)) return;
    CGPoint offset = [sender translationInView:sender.view];
    sender.view.transform = CGAffineTransformTranslate(sender.view.transform, offset.x, offset.y);
    // 坐标系清零，防止重复累加
    [sender setTranslation:CGPointZero inView:sender.view];
    
    // 拖拽不松手sender.view.center是不会改变的
    CGFloat changeX = sender.view.center.x - currentPoint.x;
    CGFloat changeY = sender.view.center.y - currentPoint.y;

    CGFloat changeDistance = sqrt(changeX*changeX + changeY*changeY);
    if (sender.state == UIGestureRecognizerStateEnded) {
        UIGravityBehavior *g = [[UIGravityBehavior alloc] initWithItems:@[sender.view]];
        UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[sender.view] mode:UIPushBehaviorModeInstantaneous];
        push.pushDirection = CGVectorMake(changeX, changeY);
        push.magnitude = changeDistance * 0.009 + 0.1;
        
        [self.animator addBehavior:g];
        [self.animator addBehavior:push];
    }
    
    
}

@end
