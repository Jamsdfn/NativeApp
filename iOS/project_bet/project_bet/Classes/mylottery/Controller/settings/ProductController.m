//
//  ProductController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ProductController.h"
#import "Product.h"
#import "ProductCell.h"
@interface ProductController ()

@property (nonatomic, strong) NSArray *products;

@end

@implementation ProductController


- (NSArray *)products{
    if (!_products) {
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"more_project.json" ofType:nil];
        // 先转为NSData
        NSData *data = [NSData dataWithContentsOfFile:path];
        // 在转为NSArray
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *arrM = [NSMutableArray new];
        for (NSDictionary *item in array) {
            Product *model = [Product productWithDictionary:item];
            [arrM addObject:model];
        }
        _products = arrM;
    }
    return _products;
}

static NSString* const reuseIdentifier = @"Product_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self products];
    UINib *nib = [UINib nibWithNibName:@"ProductCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.97 alpha:1];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Product *model = self.products[indexPath.row];
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

// 为了可以复用代码，即不用重写settingCotroller的方法，我们重写init方法
- (instancetype)init
{
    // 自动创建流式布局（自动换行）的layout
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(80, 80);
    // item 的行与行的间距
    layout.minimumLineSpacing = 30;
    // 设置一组的内边距
    layout.sectionInset = UIEdgeInsetsMake(20, 10, 0, 10);
    
    return [super initWithCollectionViewLayout:layout];
}

@end
