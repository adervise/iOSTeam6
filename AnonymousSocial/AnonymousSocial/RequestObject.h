//
//  RequestObject.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 1..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RequestObject : NSObject

+ (void)requestLogin:(NSDictionary *)userInfo;
+ (void)requestSignUp:(NSDictionary *)userInfo;
+ (void)requestLogout:(NSString *)token;
+ (void)requestPost;
+ (void)requestMyPost:(NSString *)token;

+ (void)inserMyPost:(NSString *)token content:(NSString *)content hashTags:(NSMutableArray *)hashTags backgroundImage:(UIImage *)backgroundImage;

@end
