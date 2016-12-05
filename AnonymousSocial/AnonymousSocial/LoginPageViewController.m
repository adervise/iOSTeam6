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
@property (weak, nonatomic) IBOutlet UIImageView *emailImage;
@property (weak, nonatomic) IBOutlet UIImageView *pwImage;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation LoginPageViewController


#pragma mark - View Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViewLayout];
    [LoginPageManager sharedLoginManager].loginNavigationVC = self.navigationController;
    [self addObserverForKeyboard];

}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

#pragma mark - Layout Setting

- (void)setSubViewLayout {
    
    [self transparentNavigationBar];
    [self setLayerCustomize];
}

- (void)setLayerCustomize {
    
    [self setCornerRadiusSubView:self.loginButton];
    [self setCornerRadiusSubView:self.signupButton];
    
    [self setBorderLineSubView:self.loginButton];
    [self setBorderLineSubView:self.signupButton];
}

- (void)setCornerRadiusSubView:(UIView *)view {
    
    view.layer.cornerRadius = 10.0f;
    view.clipsToBounds = YES;
    
}

- (void)setBorderLineSubView:(UIView *)view {
    
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
}


- (void)transparentNavigationBar {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - Observer

- (void)addObserverForKeyboard {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOriginView:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOriginView:) name:UIKeyboardWillHideNotification object:nil];
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

#pragma mark - Button IBAction 

- (IBAction)onTouchLoginButton:(UIButton *)sender {
    
    [[LoginPageManager sharedLoginManager] userLogin:self.emailTextField.text password:self.pwTextField.text];
}

- (IBAction)onTouchAutoLoginButton:(UIButton *)sender {
    
    [sender setSelected:!sender.selected];
    
    // Autologin check
    if (sender.selected) {
        [UserInfomation sharedUserInfomation].autoLogin = YES;
        
    } else {
    // Not autologin
        [UserInfomation sharedUserInfomation].autoLogin = NO;
    }
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
