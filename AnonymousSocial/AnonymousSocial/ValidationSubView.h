//
//  ValidationSubView.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 3..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ValidationSubviewType){
    
    ValidationSubViewTypeEmail = 0,
    ValidationSubviewTypePassword,
    ValidationSubviewTypeRePassword
};

@interface ValidationSubView : UIView

- (instancetype)initWithOriginView:(ValidationSubviewType)type;
- (void)addSubViewFromOriginView:(UIView *)view;

@end
