#import "ViewController.h"
#import "Goods.h"
#import "GoodsCell.h"
#import "FooterView.h"
// 遵守协议
@interface ViewController () <UITableViewDataSource, FooterViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *goods;

@end

@implementation ViewController

// 改变状态栏的颜色
//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}
// 隐藏状态栏
//-(BOOL)prefersStatusBarHidden{
//    return YES;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 64;
    // 设置footerview,tableFooterView 的特点：只能修改X和height，Y和width是不能改的
//    self.tableView.tableFooterView
    FooterView *footerView = [FooterView footerView];
//    footerView.tableView = self.tableView;
    self.tableView.tableFooterView = footerView;
//    NSLog(@"%@", self.tableView);
    footerView.delegate = self;
    
}

- (void)footerViewUpdateData:(FooterView *)footerView{
    // 实现加载更多方法
    Goods *model = [Goods new];
    model.title = @"驴肉火烧";
    model.price = @"6";
    model.buyCount = @"3000";
    model.icon = @"37e4761e6ecf56a2d78685df7157f097.png";
    [self.goods addObject:model];
    [self.tableView reloadData];
    NSIndexPath *idx = [NSIndexPath indexPathForRow:self.goods.count -1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:idx atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (NSMutableArray *)goods{
    if (!_goods) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tgs.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in arr) {
            Goods *model = [Goods goodsWithDictionary:item];
            [arrM addObject:model];
        }
        _goods = arrM;
    }
    return _goods;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Goods *model = self.goods[indexPath.row];
    NSString *ID = @"good_cell";
    GoodsCell *cell = [GoodsCell goodsCellWithidentifier:ID andTableView:tableView];
    cell.good = model;
    return cell;
}

@end
