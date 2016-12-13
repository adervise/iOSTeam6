//
//  SignUpPageViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 1..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "SignUpPageViewController.h"
#import "LoginPageManager.h"
#import "UserInfomation.h"
#import "UserInfoValidationCheck.h"
#import "ValidationSubView.h"
#import "CustomAlertController.h"

@interface SignUpPageViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentsView;
@property (weak, nonatomic) IBOutlet UIView *idView;
@property (weak, nonatomic) IBOutlet UIView *pwView;
@property (weak, nonatomic) IBOutlet UIView *repwView;
@property (weak, nonatomic) IBOutlet UIView *birthView;
@property (weak, nonatomic) IBOutlet UIView *genderView;

@property (weak, nonatomic) IBOutlet UITextField *idTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePwTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegment;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@property (weak, nonatomic) IBOutlet UIImageView *emailCheckImage;
@property (weak, nonatomic) IBOutlet UIImageView *pwCheckImage;
@property (weak, nonatomic) IBOutlet UIImageView *rePwCheckImage;


@property UIDatePicker *datePicker;

@end

@implementation SignUpPageViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addObserverForKeyboard];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self setSubViewLayout];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

#pragma mark - Observer for KeyboardNotification

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

#pragma mark - Button Method (IBAction..)

- (IBAction)onTouchSignUpButton:(id)sender {
    
    // 각필드의 유효성을 다시한번... 검사하여 모두 참일시 가입요청!!
    BOOL isCorrectEmailValidation = [UserInfoValidationCheck userEmailValidationCheck:self.idTextField.text];
    BOOL isCorrectPasswordValidation = [UserInfoValidationCheck userPasswordValidationCheck:self.pwTextField.text];
    BOOL isCorrectRePasswordValidation = self.rePwCheckImage.highlighted;
    
    if (isCorrectEmailValidation && isCorrectPasswordValidation && isCorrectRePasswordValidation) {
        
        NSString *userGender;
        if (self.genderSegment.selectedSegmentIndex == 0)
            userGender = @"M";
        else
            userGender = @"F";

        NSMutableDictionary *userSignUp = [[NSMutableDictionary alloc] init];
        [userSignUp setObject:_idTextField.text forKey:@"email"];
        [userSignUp setObject:_pwTextField.text forKey:@"password1"];
        [userSignUp setObject:_rePwTextField.text forKey:@"password2"];
        [userSignUp setObject:_birthTextField.text forKey:@"age"];
        [userSignUp setObject:userGender forKey:@"gender"];
        
        [[LoginPageManager sharedLoginManager] userSignUp:userSignUp completion:^(BOOL success, id data) {
           
            if (success) {
                //회원가입 성공시
                [CustomAlertController showCutomAlert:self type:CustomAlertTypeCompleteSingup completion:nil];
                [UserInfomation sharedUserInfomation].userLogin = YES;
                [[UserInfomation sharedUserInfomation] settingUserToken:[data objectForKey:@"key"]];
                [UserInfomation sharedUserInfomation].userID = [data objectForKey:@"user"];
            }

            else
                // 회원가입 실패시
                [CustomAlertController showCutomAlert:self type:CustomAlertTypeFailSignup completion:nil];
            
        }];
    }
}


#pragma mark - Custom ActionSheet

- (void)showCustomActionSheet {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [dateView setBackgroundColor:[UIColor clearColor]];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.datePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventValueChanged];
    [dateView addSubview:self.datePicker];
    [alert.view addSubview:dateView];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dateSelected:(UIDatePicker *)datePicker {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    [df setDateFormat:@"yyyy-MM-dd"];
    self.birthTextField.text = [df stringFromDate:self.datePicker.date];
}


#pragma mark - TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {

    if (textField == self.idTextField) {
        
        self.idTextField.text = @"";
        [self.emailCheckImage setHighlighted:NO];
        [self.emailCheckImage setHidden:YES];
        
    } else if (textField == self.pwTextField) {
        
        self.pwTextField.text = @"";
        [self.pwCheckImage setHighlighted:NO];
        [self.pwCheckImage setHidden:YES];
        
    } else if (textField == self.rePwTextField) {
        
        self.rePwTextField.text = @"";
        [self.rePwCheckImage setHighlighted:NO];
        [self.rePwCheckImage setHidden:YES];
        
    } else {
        
        [self showCustomActionSheet];
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self.emailCheckImage setHidden:NO];
    
    BOOL emailValidationCheck = [UserInfoValidationCheck userEmailValidationCheck:_idTextField.text];
    BOOL passwordValidationCheck = [UserInfoValidationCheck userPasswordValidationCheck:_pwTextField.text];
    BOOL rePasswordValidationCheck = [UserInfoValidationCheck userPasswordValidationCheck:_rePwTextField.text];
    
    if (textField == self.idTextField) {
        
        if (emailValidationCheck) {
            
            [self.emailCheckImage setHighlighted:YES];
            
        } else {
            
            // 오류를 나타내는 뷰 띄우기
            ValidationSubView *errorView = [[ValidationSubView alloc] initWithOriginView:ValidationSubViewTypeEmail];
            [errorView addSubViewFromOriginView:self.contentsView];
        }
        
    } else if (textField == _pwTextField) {
        
        [self.pwCheckImage setHidden:NO];
        
        if (passwordValidationCheck) {
            
            [self.pwCheckImage setHighlighted:YES];
            
        } else {
            
            // 오류를 나타내는 뷰 띄우기
            ValidationSubView *errorView = [[ValidationSubView alloc] initWithOriginView:ValidationSubviewTypePassword];
            [errorView addSubViewFromOriginView:self.contentsView];
        }
        
    } else if (textField == self.rePwTextField) {
        
        [self.rePwCheckImage setHidden:NO];
        BOOL isPasswordValidate = [UserInfoValidationCheck userPasswordValidationCheck:textField.text];
        BOOL isPasswordMatch = [textField.text isEqualToString:self.pwTextField.text];
        
        if (isPasswordValidate && isPasswordMatch) {
            
            [self.rePwCheckImage setHighlighted:YES];
            
        } else {
            
            // 오류를 나타내는 뷰 띄우기
            ValidationSubView *errorView = [[ValidationSubView alloc] initWithOriginView:ValidationSubviewTypeRePassword];
            [errorView addSubViewFromOriginView:self.contentsView];
        }
    }
    
    if (emailValidationCheck && passwordValidationCheck && rePasswordValidationCheck)
        _signupButton.enabled = YES;
    else
        _signupButton.enabled = NO;
}

#pragma mark - setSubViewLayout

- (void)setSubViewLayout {
    
    [self transparentNavigationBar];
    [self setLayerCustomize];
}

- (void)transparentNavigationBar {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (void)setLayerCustomize {
    
    [self setCornerRadiusSubView:self.idView];
    [self setCornerRadiusSubView:self.pwView];
    [self setCornerRadiusSubView:self.repwView];
    [self setCornerRadiusSubView:self.birthView];
    [self setCornerRadiusSubView:self.genderView];
    [self setCornerRadiusSubView:self.signupButton];
    
    [self setBorderLineSubView:self.idView];
    [self setBorderLineSubView:self.pwView];
    [self setBorderLineSubView:self.repwView];
    [self setBorderLineSubView:self.birthView];
    [self setBorderLineSubView:self.signupButton];
}

- (void)setBorderLineSubView:(UIView *)view {
    
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
}

- (void)setCornerRadiusSubView:(UIView *)view {
    
    view.layer.cornerRadius = 10.0f;
    view.clipsToBounds = NO;

}

#pragma mark - Memory Issue

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
