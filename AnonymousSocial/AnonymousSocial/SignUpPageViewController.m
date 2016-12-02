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

@interface SignUpPageViewController ()<UITextFieldDelegate>

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


@property UIDatePicker *datePicker;

@end

@implementation SignUpPageViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubViewLayout];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    
}


#pragma mark - Others..


#pragma mark - Button Method (IBAction..)

- (IBAction)onTouchSignUpButton:(id)sender {
    
    [[LoginPageManager sharedLoginManager] userSignUp:self.idTextField.text password:self.pwTextField.text rePassword:self.rePwTextField.text birthDay:self.birthTextField.text gender:nil];
}


#pragma mark - Custom ActionSheet

- (void)showCustomActionSheet {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIView *dateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [dateView setBackgroundColor:[UIColor clearColor]];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.datePicker addTarget:self action:@selector(dateSelected:) forControlEvents:UIControlEventEditingDidEnd];
    [dateView addSubview:self.datePicker];
    [alert.view addSubview:dateView];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dateSelected:(UIDatePicker *)datePicker {
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    [df setDateFormat:@"yyyy-mm-dd"];
    self.birthTextField.text = [df stringFromDate:self.datePicker.date];
}


#pragma mark - TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == self.birthTextField) {
        
        [self showCustomActionSheet];
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
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
    
    [self setBorderLineSubView:self.idView];
    [self setBorderLineSubView:self.pwView];
    [self setBorderLineSubView:self.repwView];
    [self setBorderLineSubView:self.birthView];
    
}

- (void)setBorderLineSubView:(UIView *)view {
    
    view.layer.borderWidth = 0.5f;
    view.layer.borderColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5].CGColor;
}

- (void)setCornerRadiusSubView:(UIView *)view {
    
    view.layer.cornerRadius = 10.0f;
    view.clipsToBounds = YES;

}

#pragma mark - Memory Issue

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
