//
//  UserInfomation.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 30..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "UserInfomation.h"
#import "CoreLocation/CoreLocation.h"
#import "RequestObject.h"

@interface UserInfomation ()<CLLocationManagerDelegate>

@property __block NSString *userToken;
@property CLLocationManager *locationManager;
@property NSTimer *locationUpdateTimer;

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
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
//        _locationUpdateTimer = [[NSTimer alloc] init];
    }
    return self;
}

- (void)settingUserToken:(NSString *)token {
    
    self.userToken = token;
    self.userLogin = YES;
}

- (NSString *)gettingUserToken {
    
    return self.userToken;
}

- (void)confirmUserLocation:(BOOL)confirm {
    
    if (confirm && self.userLogin) {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        [self.locationManager requestWhenInUseAuthorization];
        self.userLocation = YES;
        
        _locationUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:30.0f target:self selector:@selector(updatingUserLocation) userInfo:nil repeats:YES];
    } else if (!confirm) {
        _userLocation = NO;
        [_locationUpdateTimer invalidate];
    }
}

- (void)updatingUserLocation {
    
    [self.locationManager startUpdatingLocation];
    
}


#pragma mark - CLLocationManager Delegate Method

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *userNowLocation = locations.lastObject;
    CLLocationDegrees latitude = userNowLocation.coordinate.latitude;
    CLLocationDegrees longitude = userNowLocation.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
    
    NSString *latitudeString = [NSString stringWithFormat:@"%lf", latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%lf", longitude];
    NSString *userToken = [[UserInfomation sharedUserInfomation] gettingUserToken];
    // 여기에 받아온 위치정보를 서버로 업데이트 시키자!!
    [RequestObject updateUserLocation:userToken latitude:latitudeString hardness:longitudeString];
    
}

@end
