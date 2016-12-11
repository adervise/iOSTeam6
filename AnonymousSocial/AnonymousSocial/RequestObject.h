//
//  RequestObject.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 1..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LoginPageManager.h"
#import "HomeVCManager.h"


@interface RequestObject : NSObject

// 로그인, 로그아웃 및 회원가입
+ (void)requestLogin:(NSDictionary *)userInfo completion:(LoginCompletion)completion;
+ (void)requestSignUp:(NSDictionary *)userInfo completion:(LoginCompletion)completion;
+ (void)requestLogout:(NSString *)token completion:(NetworkCompletion)completion;

// 글리스트 요청
+ (void)requestPostList:(NetworkCompletion)completion;
// 다음글 요청
+ (void)requestNextPost:(NSString *)nextURL completion:(NetworkCompletion)completion;

// 내가쓴글 요청
+ (void)requestMyPost:(NSString *)token completion:(NetworkCompletion)completion;

+ (void)inserMyPost:(NSString *)token content:(NSString *)content hashTags:(NSMutableArray *)hashTags backgroundImage:(UIImage *)backgroundImage;

+ (void)updateUserLocation:(NSString *)token latitude:(NSString *)latitude hardness:(NSString *)hardness;

@end
