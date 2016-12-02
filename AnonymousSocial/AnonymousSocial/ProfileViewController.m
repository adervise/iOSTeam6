//
//  ProfileViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 2..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginPageManager.h"
#import "UserInfomation.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 
 viewWillAppear에서 사용자의 로그인상태를 체크하여 보이는 화면을 다르게할 수 있도록 하자!!
 
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSLog(@"------------------------ProfileViewController viewWillAppear!!!");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button IBAction Method

- (IBAction)onTouchLogoutButton:(UIButton *)sender {
    
    [[LoginPageManager sharedLoginManager] userLogout:[[UserInfomation sharedUserInfomation] gettingUserToken]];
}


@end
