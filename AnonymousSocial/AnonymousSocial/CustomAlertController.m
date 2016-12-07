//
//  CustomAlertController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 2..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CustomAlertController.h"

@interface CustomAlertController ()

@end

@implementation CustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)showCutomAlert:(UIViewController *)vc type:(CustomAlertType)type{
    
    UIAlertController *alert = nil;
    
    switch (type) {
            
        case CustomAlertTypeCompleteLogin: {
            alert = [UIAlertController alertControllerWithTitle:@"로그인 되었습니다." message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [vc dismissViewControllerAnimated:YES completion:nil];
            }];
            [alert addAction:okAction];
            break;
        }
            
        case CustomAlertTypeCompleteSingup:
            break;
            
        case CustomAlertTypeRequiredLogin: {
            
            alert = [UIAlertController alertControllerWithTitle:@"로그인이 필요한 기능입니다." message:@"로그인 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                UINavigationController *nextVC = (UINavigationController *)[story instantiateViewControllerWithIdentifier:@"LoginNavigationCotroller"];
                [vc presentViewController:nextVC animated:YES completion:nil];
                
            }];
            UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okAction];
            [alert addAction:cancleAction];
            break;
        }
        default:
            break;
    }
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (void)showCustomLogoutAlert:(UITabBarController *)tabBarVC navigationVC:(UINavigationController *)navigationVC {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"로그아웃 되었습니다." message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        tabBarVC.selectedIndex = 0;
        [navigationVC popToRootViewControllerAnimated:NO];

    }];
    [alert addAction:okAction];
    
    [tabBarVC presentViewController:alert animated:YES completion:nil];
}

@end
