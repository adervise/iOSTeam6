//
//  LayerCustomUtility.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 5..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LayerCustomUtility : NSObject

+ (void)changeCornerRadius:(CALayer *)layer;
+ (void)changeTopBottomBorderLine:(UIView *)view;
+ (void)transparentToNavigationBar:(UIViewController *)vc;
+ (void)shadowEffectForCell:(CALayer *)layer shadowOffset:(CGFloat)offset;

@end
