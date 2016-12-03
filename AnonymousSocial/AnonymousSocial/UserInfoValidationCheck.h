//
//  UserInfoValidationCheck.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 3..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoValidationCheck : NSObject

+ (BOOL)userEmailValidationCheck:(NSString *)email;
+ (BOOL)userPasswordValidationCheck:(NSString *)password;

@end
