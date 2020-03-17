//
//  ProductCell.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "ProductCell.h"

@interface ProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation ProductCell

- (void)setModel:(Product *)model{
    _model = model;
    // 把icon处理成圆角
    self.imageView.layer.cornerRadius = 10;
    // 切去剩余部分
    self.imageView.layer.masksToBounds = YES;
    
    self.imageView.image = [UIImage imageNamed:model.icon];
    self.title.text = model.title;
}

@end
