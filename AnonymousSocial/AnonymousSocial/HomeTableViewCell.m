//
//  HomeTableViewCell.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 28..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()

// Private Properties

@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
 
    [self setupCellLayoutStyle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

- (void)setupCellLayoutStyle {
    
    //백그라운드이미지뷰의 layer를 조정하여 둥글게.
    self.backGroundImage.layer.cornerRadius = 20.0f;
    
    // Cell에 섀도우이펙트(?)
    [self shadowEffectForCell];
    
    // infoContensView 상단에 border추가
    [self drawTopBorderLine];
}

- (void)shadowEffectForCell {
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowRadius = 1;
    self.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
}

- (void)drawTopBorderLine {
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, self.infoContentsView.bounds.size.width, 0.8f);
    topBorder.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.4].CGColor;
    [self.infoContentsView.layer addSublayer:topBorder];
}

@end
