//
//  ProfileManager.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "ProfileManager.h"
#import "RequestObject.h"
#import "UserInfomation.h"

@implementation ProfileManager

+ (instancetype)sharedManager {
    
    static ProfileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[ProfileManager alloc] init];
    });
    
    return manager;
}

- (void)requestMyPostListData {
    
    [RequestObject requestMyPost:[[UserInfomation sharedUserInfomation] gettingUserToken]];
}

- (void)completeMyPostListData:(void(^)(ProfileViewController *profileVC, MyCommentViewController *commentVC))completion {
    
    completion(self.profileViewController, self.commentViewController);
}

@end
