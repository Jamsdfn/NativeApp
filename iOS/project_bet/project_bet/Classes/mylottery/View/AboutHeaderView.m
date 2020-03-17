//
//  AboutHeaderView.m
//  project_bet
//
//  Created by Jamsdfn on 2020/3/17.
//  Copyright © 2020 Alexander. All rights reserved.
//

#import "AboutHeaderView.h"

@implementation AboutHeaderView


+ (instancetype)aboutHeaderView{
    return [[NSBundle mainBundle] loadNibNamed:@"AboutHeaderView" owner:nil options:nil][0];
}

@end
