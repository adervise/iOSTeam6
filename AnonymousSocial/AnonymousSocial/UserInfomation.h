//
//  UserInfomation.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 30..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfomation : NSObject

@property (getter=isUserLogin) BOOL userLogin;
@property (getter=isAutoLogin) BOOL autoLogin;

+ (instancetype)sharedUserInfomation;
- (void)settingUserToken:(NSString *)token;
- (NSString *)gettingUserToken;

@end
