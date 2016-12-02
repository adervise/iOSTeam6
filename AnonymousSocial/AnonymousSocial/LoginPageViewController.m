//
//  LoginPageViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 30..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "LoginPageViewController.h"
#import "UserInfomation.h"

@interface LoginPageViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *textFieldContainerView;
@property (weak, nonatomic) IBOutlet UIView *otherButtonContainerView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UIImageView *checkBoxImage;
@property (weak, nonatomic) IBOutlet UIImageView *emailImage;
@property (weak, nonatomic) IBOutlet UIImageView *pwImage;

@end

@implementation LoginPageViewController


#pragma mark - View Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [LoginPageManager sharedLoginManager].loginNavigationVC = self.navigationController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserverForKeyboard];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
//    [[NSNotificationCenter defaultCenter] removeObserver:@"UserTokenChanged"];
}

#pragma mark - Observer

- (void)addObserverForKeyboard {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOriginView:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOriginView:) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserToken:) name:@"UserTokenChanged" object:nil];
}


- (void)changeOriginView:(NSNotification *)notification {
    
    CGRect keyboardFrame = [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    if ([notification.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        
        [UIView animateWithDuration:1.0f animations:^{
            [self.view setFrame:CGRectMake(0, -(keyboardFrame.size.height/2), self.view.bounds.size.width, self.view.bounds.size.height)];
        }];
    }
    else if([notification.name isEqualToString:@"UIKeyboardWillHideNotification"]) {
        
        [UIView animateWithDuration:1.0f animations:^{
            [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        }];
    }
}

//- (void)changeUserToken:(NSNotification *)notification {
//    
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//       
//        // 로그인 되었습니다 얼럿창
//    }];
//}

#pragma mark - Button IBAction 

- (IBAction)onTouchLoginButton:(UIButton *)sender {
    
    [[LoginPageManager sharedLoginManager] userLogin:self.emailTextField.text password:self.pwTextField.text];
}

#pragma mark - TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.emailTextField) {
        [self.pwTextField becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

#pragma mark - Memory Issue

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
