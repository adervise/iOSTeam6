//
//  CustomCollectionViewCell.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 28..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // ImageView에 여러효과 추가
    [self setupCellLayoutStyle];
}

- (void)setupCellLayoutStyle {
    
    //백그라운드이미지뷰의 layer를 조정하여 둥글게.
    self.standradView.layer.masksToBounds = YES;
//    self.standradView.layer.cornerRadius = 15.0f;
    self.standradView.layer.borderWidth = 0.3f;
    
    // infoView의 상단에만 border를 보이게하기 (편법?)
    [self drawTopBorderLine];
    
    // Cell에 섀도우이펙트(?)
    [self shadowEffectForCell];
}

- (void)drawTopBorderLine {
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, self.infoView.bounds.size.width, 0.5f);
    topBorder.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor;
    [self.infoView.layer addSublayer:topBorder];
}

- (void)shadowEffectForCell {
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 1;
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
}

@end
