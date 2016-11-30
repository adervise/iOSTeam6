//
//  LoginPageViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 30..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "LoginPageViewController.h"

@interface LoginPageViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UIImageView *appIconImage;
@property (weak, nonatomic) IBOutlet UIView *textFieldView;
@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;


@end

@implementation LoginPageViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self layerLayoutSubView];
    [self addobservers];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Add Observer 

- (void)addobservers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Setting View's Layout

- (void)layerLayoutSubView {
    
    self.backView.layer.cornerRadius = 5.0f;
    [self shadowEffect:self.backView];
    
}

- (void)shadowEffect:(UIView *)view {
    view.layer.shadowColor = [UIColor blueColor].CGColor;
    view.layer.shadowOpacity = 0.4;
    view.layer.shadowRadius = 1;
    view.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

#pragma mark - selector Method

- (void)keyboardFrameDidChange:(NSNotification *)notification {
    
    CGRect keyboardFrame = [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    // 키보드가 나타나기직전.
    if ([notification.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        
        [UIView animateWithDuration:0.3f animations:^{
            [self.view setFrame:CGRectMake(0, - (keyboardFrame.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height)];
        }];
    // 키보드가 사라지기 직전
    } else if ([notification.name isEqualToString:@"UIKeyboardWillHideNotification"]) {
        
        [UIView animateWithDuration:0.3f animations:^{
           
            [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        }];
    }
}

#pragma mark - TextFieldDelegate Method

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    // iOS 기본키보드 높이만큼 해당뷰의 y좌표를 위로올린다.
    
    
    NSLog(@"textField clicked!!");
    return YES;
}

@end
