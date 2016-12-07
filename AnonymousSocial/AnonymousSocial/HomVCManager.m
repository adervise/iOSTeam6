//
//  HomVCManager.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "HomVCManager.h"
#import "RequestObject.h"

@interface HomVCManager ()

@end

@implementation HomVCManager

+ (instancetype)sharedManager {
    
    static HomVCManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[HomVCManager alloc] init];
    });
    
    return manager;
}

- (void)requestPostData {
    
    [RequestObject requestPost];
}


@end
