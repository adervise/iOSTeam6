//
//  CustomProfileCollectionCell.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 5..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CustomProfileCollectionCell.h"

@interface CustomProfileCollectionCell ()

@property (weak, nonatomic) IBOutlet UIView *standradVIew;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@end

@implementation CustomProfileCollectionCell


- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupCellLayoutStyle];
}

 
- (void)setupCellLayoutStyle {
    
    //백그라운드이미지뷰의 layer를 조정하여 둥글게.
    self.standradVIew.layer.masksToBounds = YES;
    self.standradVIew.layer.cornerRadius = 5.0f;
    self.standradVIew.layer.borderWidth = 0.3f;
    
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
    
    self.standradVIew.layer.shadowColor = [UIColor blackColor].CGColor;
    self.standradVIew.layer.shadowOpacity = 0.3;
    self.standradVIew.layer.shadowRadius = 1;
    self.standradVIew.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
}


@end
