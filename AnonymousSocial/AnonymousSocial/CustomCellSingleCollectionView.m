//
//  CustomCellSingleCollectionView.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 29..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CustomCellSingleCollectionView.h"

@interface CustomCellSingleCollectionView ()

@end

@implementation CustomCellSingleCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //
    [self setupCellLayoutStyle];
}

- (void)setupCellLayoutStyle {
    
    [self drawTopBorderLine];
}

- (void)drawTopBorderLine {
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, self.infoContentsView.bounds.size.width, 0.5f);
    topBorder.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
    [self.infoContentsView.layer addSublayer:topBorder];
}

@end
