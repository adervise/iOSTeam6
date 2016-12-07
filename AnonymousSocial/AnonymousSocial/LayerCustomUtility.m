//
//  LayerCustomUtility.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 5..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "LayerCustomUtility.h"

@implementation LayerCustomUtility

+ (void)changeCornerRadius:(CALayer *)layer {
    
    layer.cornerRadius = 5.0f;
}

+ (void)changeTopBottomBorderLine:(UIView *)view {
    
    CALayer *topBorder = [CALayer layer];
    CALayer *bottomBorder = [CALayer layer];
    
    topBorder.frame = CGRectMake(0.0f, 0.0f, view.bounds.size.width, 0.4f);
    bottomBorder.frame = CGRectMake(0.0f, view.bounds.size.height, view.bounds.size.width, 0.4f);
    
    topBorder.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
    bottomBorder.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4].CGColor;
    
    [view.layer addSublayer:topBorder];
    [view.layer addSublayer:bottomBorder];
}

+ (void)transparentToNavigationBar:(UIViewController *)vc {
    
    [vc.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    vc.navigationController.navigationBar.shadowImage = [UIImage new];
    vc.navigationController.navigationBar.translucent = YES;
    vc.navigationController.view.backgroundColor = [UIColor clearColor];
}

+ (void)shadowEffectForCell:(CALayer *)layer shadowOffset:(CGFloat)offset {
    
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3;
    layer.shadowRadius = 1;
    layer.shadowOffset = CGSizeMake(offset, offset);
}

@end
