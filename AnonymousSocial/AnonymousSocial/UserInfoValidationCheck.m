//
//  UserInfoValidationCheck.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 3..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "UserInfoValidationCheck.h"

@implementation UserInfoValidationCheck

+ (BOOL)userEmailValidationCheck:(NSString *)email {
    
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)userPasswordValidationCheck:(NSString *)password {
    
    BOOL passwordValidation = YES;
    
    // 6자 이상
    if([password length] < 6)
        passwordValidation = NO;
    
    // 대문자 포함
    NSCharacterSet *charSet = [NSCharacterSet uppercaseLetterCharacterSet];
    NSRange range = [password rangeOfCharacterFromSet:charSet];
    if(range.location == NSNotFound)
        passwordValidation = NO;
    
    // 소문자 포함
    charSet = [NSCharacterSet lowercaseLetterCharacterSet];
    range = [password rangeOfCharacterFromSet:charSet];
    if(range.location == NSNotFound)
        passwordValidation = NO;
    
    // 특수문자포함
    charSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    range = [password rangeOfCharacterFromSet:charSet];
    if(range.location == NSNotFound)
        passwordValidation = NO;
    
    return passwordValidation;
}


@end
