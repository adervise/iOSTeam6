//
//  UserSettingViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 5..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "UserSettingViewController.h"
#import "LoginPageManager.h"
#import "UserInfomation.h"

@interface UserSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property NSArray *dataArray;
@property UISwitch *locationSwitch;

@end

@implementation UserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = @[@[@"위치정보 허용"],@[@"정보수정", @"로그아웃"]];
    self.locationSwitch = [[UISwitch alloc] init];
    [self.locationSwitch addTarget:self action:@selector(didChangedLocationSwitchValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //여기에서 UerInfomation에서의 위치정보 허용값과 스위치의 값을 일치시킨다! (즉, 설정칸에서도 위치정보허용을 할 수 있고 글을 작성시에도 허용할 수 있어
    //                                                           싱크를 맞춰야할 것이다.)
    [self locationSwitchValueWithUserLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)locationSwitchValueWithUserLocation {
    
    if ([UserInfomation sharedUserInfomation].userLocation)
        [_locationSwitch setOn:YES];
    else
        [_locationSwitch setOn:NO];
}

- (void)didChangedLocationSwitchValue:(UISwitch *)sender {
    
    // 위치정보 허용 or 제한
    if (sender.on)
        [[UserInfomation sharedUserInfomation] confirmUserLocation:YES];
    else
        [[UserInfomation sharedUserInfomation] confirmUserLocation:NO];
}

#pragma mark - TableView DataSource Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell setAccessoryView:self.locationSwitch];
    }
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    // 현재는 세팅의 가짓수가 적어 section을 하나로만 설정했지만
    // 규모가 커진다면 다시 고려해야할것이다.
    NSString *footerString;
    
    if (section == 0)
        footerString = @"매 30초마다 위치정보를 자동으로 가져옵니다.";
    else if(section == 1)
        footerString = @"회원정보를 수정하거나 로그아웃합니다.";
    
    return footerString;
}

#pragma mark - TableView Delegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        }
        
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1) {
            [CustomAlertController showCutomAlert:self type:CustomAlertTypeLogout completion:^(UIAlertAction *action){
                // 사용자가 로그아웃할 시
                [CustomAlertController showCutomAlert:self type:CustomAlertTypeCompleteLogout completion:^(UIAlertAction *action){
                    
                    [[UserInfomation sharedUserInfomation] settingUserToken:nil];
                    [UserInfomation sharedUserInfomation].userLogin = NO;
                    [UserInfomation sharedUserInfomation].autoLogin = NO;
                    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:@"AnonymousSocial" accessGroup:nil];
                    [keyChain resetKeychainItem];
                    [self.tabBarController setSelectedIndex:0];
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }];
            }];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPat {
    
    return YES;
}

@end
