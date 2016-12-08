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

+ (void)userPost:(NSString *)content hashTags:(NSMutableArray *)hashTags backgroundImage:(UIImage *)backgroundImage {
    
    [RequestObject inserMyPost:[[UserInfomation sharedUserInfomation] gettingUserToken] content:content hashTags:hashTags backgroundImage:backgroundImage];
}


@end
