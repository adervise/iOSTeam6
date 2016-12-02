//
//  LoginPageManager.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 1..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "LoginPageManager.h"
#import "RequestObject.h"
#import "UserInfomation.h"
#import "CustomAlertController.h"


@interface LoginPageManager ()

@end

@implementation LoginPageManager


+ (instancetype)sharedLoginManager {
    
    static LoginPageManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[LoginPageManager alloc] init];
    });
    
    return manager;
}

// RequestObject에 유저에대한 정보를담아 회원가입메소드를 호출
- (void)userSignUp:(NSString *)email password:(NSString *)userPW rePassword:(NSString *)rePW birthDay:(NSString *)birthDay gender:(NSString *)gender {
    
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
    [userInfoDic setObject:email forKey:@"email"];
    [userInfoDic setObject:userPW forKey:@"password1"];
    [userInfoDic setObject:rePW forKey:@"password2"];
    
    [RequestObject requestSignUp:userInfoDic];
}

- (void)completeLogin:(nonnull NSString *)token {
    
/*
 RequestObject에서 토큰을 받아와서
 UserInfomagion 싱글톤객체에 유저정보를 업데이트
 LoginNavigation 을 해제
 */
    [[UserInfomation sharedUserInfomation] settingUserToken:token];
    
    //이부분에 "로그인되었습니다" 란 얼럿창 띄우기
    [CustomAlertController showCutomAlert:self.loginNavigationVC type:CustomAlertTypeCompleteLogin];
    
}

- (void)userLogin:(NSString *)email password:(NSString *)password {
    
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
    [userInfoDic setObject:email forKey:@"email"];
    [userInfoDic setObject:password forKey:@"password"];
    
    [RequestObject requestLogin:userInfoDic];
}

- (void)userLogout:(NSString *)token {
    
    [RequestObject requestLogout:token];
}

- (void)completeUserLogout:(nonnull NSString *)token {
    
    // 로그아웃 되었으니 유저정보를 다시세팅!!
    [[UserInfomation sharedUserInfomation] settingUserToken:nil];
    [CustomAlertController showCustomLogoutAlert:self.homeViewController];
}


@end
