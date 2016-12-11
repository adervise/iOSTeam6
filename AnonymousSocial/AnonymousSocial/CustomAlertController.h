//
//  CustomAlertController.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 2..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginPageManager.h"

typedef NS_ENUM(NSInteger, CustomAlertType) {
    CustomAlertTypeCompleteLogin = 1,
    CustomAlertTypeFailLogin,
    CustomAlertTypeCompleteSingup,
    CustomAlertTypeFailSignup,
    CustomAlertTypeRequiredLogin,
    CustomAlertTypeLogout,
    CustomAlertTypeCompleteLogout
};

@interface CustomAlertController : UIAlertController

+ (void)showCutomAlert:(UIViewController *)vc type:(CustomAlertType)type completion:(AlertCompletion)completion;


@end
