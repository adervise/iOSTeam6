//
//  UserInfomation.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 30..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "UserInfomation.h"

@interface UserInfomation ()



@end

@implementation UserInfomation

// 싱글톤 객체 생성
+ (instancetype)sharedUserInfomation {
    
    static UserInfomation *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        info = [[UserInfomation alloc] init];
    });
    
    return info;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        // 여기에서 초기화값을 설정!!
        _userLogin = NO;
    }
    return self;
}


@end
