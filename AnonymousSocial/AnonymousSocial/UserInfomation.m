//
//  UserInfomation.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 30..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "UserInfomation.h"
#import "CoreLocation/CoreLocation.h"

@interface UserInfomation ()<CLLocationManagerDelegate>

@property NSString *userToken;
@property CLLocationManager *locationManager;

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

- (void)settingUserToken:(NSString *)token {
    
    self.userToken = token;
    self.userLogin = YES;
}

- (NSString *)gettingUserToken {
    
    return self.userToken;
}

- (void)denyUserLocation {
    
    if (self.userLogin) {
        
        self.userLocation = NO;
    }
}

- (void)confirmUserLocation {
    
    UserInfomation __weak *wSelf = self;
    
    if (self.userLogin) {
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = wSelf;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        [self.locationManager requestWhenInUseAuthorization];
        self.userLocation = YES;
    }
    //임시
    [self updatingUserLocation];
}

- (void)updatingUserLocation {
    
    if ([self isUserLocation]) {
        dispatch_queue_t concurrent_queue = dispatch_queue_create("locationQueue", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(concurrent_queue, ^{
            
            [self.locationManager startUpdatingLocation];
        });
    }
}

#pragma mark - CLLocationManager Delegate Method

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *userNowLocation = locations.lastObject;
    CLLocationDegrees latitude = userNowLocation.coordinate.latitude;
    CLLocationDegrees longitude = userNowLocation.coordinate.longitude;
    
    NSLog(@"latitude = %.4f ,   longitude = %.4f", latitude, longitude);
    [self.locationManager stopUpdatingLocation];
}

@end
