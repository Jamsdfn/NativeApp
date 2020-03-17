//
//  GuideCell.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "GuideCell.h"

@interface GuideCell()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation GuideCell

-(UIImageView *)imageView{
    if(!_imageView){
        UIImageView *imageView = [UIImageView new];
        imageView.frame = KScreenSize;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    
    self.imageView.image = image;
}

@end
