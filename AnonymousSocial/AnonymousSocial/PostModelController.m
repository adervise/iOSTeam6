//
//  PostModelController.m
//  AnonymousSocial
//
//  Created by celeste on 2016. 12. 7..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "PostModelController.h"
#import "RequestObject.h"
#import "UserInfomation.h"


@implementation PostModelController

- (void)userSignUp:(NSString *)email password:(NSString *)userPW rePassword:(NSString *)rePW birthDay:(NSString *)birthDay gender:(NSString *)gender {
    
    NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
    [userInfoDic setObject:email forKey:@"email"];
    [userInfoDic setObject:userPW forKey:@"password1"];
    [userInfoDic setObject:rePW forKey:@"password2"];
    
    [RequestObject requestSignUp:userInfoDic];
}

- (void)userPost:(NSString *)content hashTags:(NSMutableArray *)hashTags backgroundImage:(UIImage *)backgroundImage {
    
    NSMutableDictionary *userPostDic = [[NSMutableDictionary alloc] init];
    [userPostDic setValue:content forKey:@"content"];

    [RequestObject inserMyPost:[[UserInfomation sharedUserInfomation] gettingUserToken] postData:userPostDic];
    
    
    
}


@end
