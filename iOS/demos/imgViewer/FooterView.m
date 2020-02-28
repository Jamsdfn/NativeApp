#import "FooterView.h"

@interface FooterView ()
- (IBAction)loadMore;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet UIView *WaitingView;


@end

@implementation FooterView

+ (instancetype)footerView{
    return [[NSBundle mainBundle] loadNibNamed:@"FooterView" owner:nil options:nil][0];
}

- (IBAction)loadMore {
    self.btnLoadMore.hidden = YES;
    self.WaitingView.hidden = NO;
//    NSLog(@"%@",self.tableView);
    // 为了代理方法不出错，我们应该先判断代理对象是否实现了这个方法，如果实现了这个方法，再调用，否则不调用
    if ([self.delegate respondsToSelector:@selector(footerViewUpdateData:)]){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.delegate footerViewUpdateData:self];
            self.btnLoadMore.hidden = NO;
            self.WaitingView.hidden = YES;
        });
        
    }
    
}

@end
