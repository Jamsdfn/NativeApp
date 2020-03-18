//
//  GuideController.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "GuideController.h"
#import "GuideCell.h"
#import "UIView+Frame.h"
#import "TabBarController.h"
@interface GuideController ()

@property (nonatomic, weak) UIImageView *largeImageView, *largeTextImageView, *smallTextImageView;
@property (nonatomic, assign) NSInteger page;

@end

@implementation GuideController

static NSString * const reuseIdentifier = @"guide_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerClass:[GuideCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // 设置一页页滑动的效果
    self.collectionView.pagingEnabled = YES;
    // 取消滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹性效果，防止在最左边还能往左划
    self.collectionView.bounces = NO;
    
    // 为了做到内容根据滑动的防止移动端对应屏幕的位置，我们只做一组imageVIew，每一个cell动重用这几个imageVIew，根据屏幕所处的cell，移动frame就好了
    UIImageView *largeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    largeImageView.x = (KScreenWidth-largeImageView.w)/2;
    largeImageView.y = (KScreenHeight-largeImageView.h)/2;
    self.largeImageView = largeImageView;
    UIImageView *largeTextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    largeTextImageView.x = (KScreenWidth-largeTextImageView.w)/2;
    largeTextImageView.y = KScreenHeight*0.7;
    self.largeTextImageView = largeTextImageView;
    
    UIImageView *smallTextImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    smallTextImageView.x = (KScreenWidth-smallTextImageView.w)/2;
    smallTextImageView.y = KScreenHeight*0.8;
    self.smallTextImageView = smallTextImageView;
    
    // 线的图片
    UIImage *image = [UIImage imageNamed:@"guideLine"];
    UIImageView *guideLine = [[UIImageView alloc] initWithImage:image];
    guideLine.x = -20;
    guideLine.y = KScreenHeight * 0.1;
    [self.collectionView addSubview:guideLine];
    
    // 添加立即体验按钮
    UIButton *tryNowBtn = [UIButton new];
    [tryNowBtn setBackgroundImage:[UIImage imageNamed:@"guideStart"] forState:UIControlStateNormal];
    [tryNowBtn sizeToFit];
    tryNowBtn.x = 3*KScreenWidth + (KScreenWidth-tryNowBtn.w)/2;
    tryNowBtn.y = KScreenHeight * 0.9;
    [tryNowBtn addTarget:self action:@selector(tryNowClick) forControlEvents:UIControlEventTouchUpInside];
    [self.collectionView addSubview:tryNowBtn];
    [self.collectionView addSubview:largeImageView];
    [self.collectionView addSubview:largeTextImageView];
    [self.collectionView addSubview:smallTextImageView];
}

// 监听立即体验按钮
- (void)tryNowClick{
    UIWindow *mainWindow = [UIApplication sharedApplication].windows[0];
    mainWindow.rootViewController = [TabBarController new];
}

// 监听collectionView滑动完成(scrollView减速完成)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = (NSInteger)(offsetX/KScreenWidth);
    NSString *largeImageName = [NSString stringWithFormat:@"guide%zd", page + 1];
    self.largeImageView.image = [UIImage imageNamed:largeImageName];
    
    NSString *largeTextImageName = [NSString stringWithFormat:@"guideLargeText%zd", page + 1];
    self.largeTextImageView.image = [UIImage imageNamed:largeTextImageName];
    
    NSString *smallTextImageName = [NSString stringWithFormat:@"guideSmallText%zd", page + 1];
    self.smallTextImageView.image = [UIImage imageNamed:smallTextImageName];
    // 从滑动方向的反方向进来
    if (page > self.page){
        self.smallTextImageView.x = offsetX + KScreenWidth;
        self.largeImageView.x = offsetX + KScreenWidth;
        self.largeTextImageView.x = offsetX + KScreenWidth;
    } else {
        self.smallTextImageView.x = offsetX - KScreenWidth;
        self.largeImageView.x = offsetX - KScreenWidth;
        self.largeTextImageView.x = offsetX - KScreenWidth;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.largeImageView.x = offsetX + (KScreenWidth-self.largeImageView.w)/2;
        self.largeTextImageView.x = offsetX + (KScreenWidth-self.largeTextImageView.w)/2;
        self.smallTextImageView.x = offsetX + (KScreenWidth-self.smallTextImageView.w)/2;
    }];
    self.page = page;
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)/255) green:((float)arc4random_uniform(256)/255) blue:((float)arc4random_uniform(256)/255) alpha:((float)arc4random_uniform(256)/255)];
    // 获取图片
    NSString *imageName = [NSString stringWithFormat:@"guide%zdBackground568h", indexPath.row + 1];
    UIImage *image = [UIImage imageNamed:imageName];
    cell.image = image;
    return cell;
}


-(instancetype)init{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = KScreenSize.size;
    layout.minimumLineSpacing = 0;
    // 滑动的方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:layout];
}

@end
