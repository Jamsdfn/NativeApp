//
//  GoodsCell.m
//  imgViewer
//
//  Created by 杜祖铧 on 2020/2/27.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "GoodsCell.h"

@interface GoodsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblBuyCount;

@end

@implementation GoodsCell

- (void)setGood:(Goods *)good{
    _good = good;
    self.imgViewIcon.image = [UIImage imageNamed:good.icon];
    self.lblTitle.text = good.title;
    self.lblPrice.text = [NSString stringWithFormat:@"￥ %@",good.price];
    self.lblBuyCount.text = [NSString stringWithFormat:@"%@ 人已购买",good.buyCount];
}

+ (instancetype)goodsCellWithidentifier:(NSString *)identifier andTableView:(UITableView *)tableView{
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:nil options:nil][0];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
