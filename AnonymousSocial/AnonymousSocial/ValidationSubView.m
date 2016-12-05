//
//  ValidationSubView.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 3..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "ValidationSubView.h"

@interface ValidationSubView ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation ValidationSubView


- (instancetype)initWithOriginView:(ValidationSubviewType)type {
    
    self = [[[NSBundle mainBundle] loadNibNamed:@"ValidationSubView" owner:self
                                        options:nil] objectAtIndex:0];
    
    if (self) {
    
        // 해당상황에 맞는 text입력
        [self putErrorText:type];
        
        self.layer.cornerRadius = 10.0f;
    }
    
    return self;
}

- (void)putErrorText:(ValidationSubviewType)type {
    
    switch (type) {
        case ValidationSubViewTypeEmail:
            self.textLabel.text = @"Email형식에 맞지 않습니다.";
            break;
            
        case ValidationSubviewTypePassword:
            self.textLabel.text = @"비밀번호는 대,소문자,특수문자 조합으로 8자 이상이어야 합니다.";
            break;
        case ValidationSubviewTypeRePassword:
            self.textLabel.text = @"위의 비밀번호와 일치하지 않습니다.";
            break;
    }
}

- (void)addSubViewFromOriginView:(UIView *)view {
    
    CGFloat originViewWidth = view.bounds.size.width;
    CGRect frame = CGRectMake(0, -40, originViewWidth, 40);
    [self setFrame:frame];
    
    [UIView animateWithDuration:2.5f animations:^{
        [view addSubview:self];
        [self setAlpha:0];
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}


@end
