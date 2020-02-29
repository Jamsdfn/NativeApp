#import "GroupHeaderView.h"
#import "Group.h"

@interface GroupHeaderView ()

@property (nonatomic, weak) UIButton *btnGroupTitle;
@property (nonatomic, weak) UILabel *lblCount;

@end

@implementation GroupHeaderView

+ (instancetype)groupHeaderViewWithtableView:(UITableView *)tableView andIdentifier:(NSString *)identifier{
    GroupHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
       if (!headerView) {
           headerView = [[GroupHeaderView alloc] initWithReuseIdentifier:identifier];
       }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIButton *btnGroupTitle = [UIButton new];
        [btnGroupTitle setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [btnGroupTitle setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [btnGroupTitle setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        // 设置内边距
        btnGroupTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btnGroupTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        // 设置内容左对齐
        btnGroupTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 防止图片旋转后拉伸
        btnGroupTitle.imageView.contentMode = UIViewContentModeCenter;
        // 防止图片旋转后超出原来现实部分被截取
        btnGroupTitle.imageView.clipsToBounds = NO;
        // 添加点击事件
        [btnGroupTitle addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btnGroupTitle];
        self.btnGroupTitle = btnGroupTitle;
        
        UILabel *lblCount = [UILabel new];
        [self.contentView addSubview:lblCount];
        self.lblCount = lblCount;
    }
    return self;
}

- (void)btnClick{
    // 标题按钮点击事件，展开或者合上组
    self.group.isVisible = !self.group.isVisible;
    if ([self.delegate respondsToSelector:@selector(reload:)]){
        [self.delegate reload:self];
    }
    // 以为reload是直接销毁，所以这样写代码是有问题的。转不动
    //self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
}


- (void)setGroup:(Group *)group{
    _group = group;
    // 设置数据
    [self.btnGroupTitle setTitle:group.name forState:UIControlStateNormal];
    [self.btnGroupTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (self.group.isVisible) {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(M_PI/2);
    } else {
        self.btnGroupTitle.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    self.lblCount.text = [NSString stringWithFormat:@"%d / %ld", group.online, group.friends.count];
    // 设置frame,注意此时的self.bounds 或者 self.frame都是零
    // 在设置组标题View方法中frame都是零，只有在tableView根据这个方法创建headerView后,frame才会改变
//    self.btnGroupTitle.frame = self.bounds;
//    CGFloat lblW = 100;
//    CGFloat lblH = self.bounds.size.height;
//    CGFloat lblY = 0;
//    CGFloat lblX = self.bounds.size.width - 10 - lblW;
//    self.lblCount.frame = CGRectMake(lblX, lblY, lblW, lblH);
}

// 当当前控件frame发生改变的时候会自动调用这个方法
- (void)layoutSubviews{
    [super layoutSubviews];
    self.btnGroupTitle.frame = self.bounds;
    CGFloat lblW = 100;
    CGFloat lblH = self.bounds.size.height;
    CGFloat lblY = 0;
    CGFloat lblX = self.bounds.size.width - 10 - lblW;
    self.lblCount.frame = CGRectMake(lblX, lblY, lblW, lblH);
}

@end
