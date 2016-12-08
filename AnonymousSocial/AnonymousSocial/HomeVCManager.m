//
//  HomeVCManager.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "HomeVCManager.h"


@interface HomeVCManager ()

@end

@implementation HomeVCManager

+ (instancetype)sharedManager {
    
    static HomeVCManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[HomeVCManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        _currentCellCount = 5;
        _nextPostDataURL = [[NSString alloc] init];
    }
    return self;
}

- (void)requestPostList:(NSString *)token completion:(NetworkCompletion)completion {
    
    [RequestObject requestPostList:token completion:completion];
}

- (void)requestNextPostListData:(NSString *)nextURL completion:(NetworkCompletion)completion {
    
    [RequestObject requestNextPost:nextURL completion:completion];
}


@end
