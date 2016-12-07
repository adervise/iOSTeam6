//
//  HomeVCManager.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "HomeVCManager.h"
#import "RequestObject.h"

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

- (void)requestPostListData {
    
    [RequestObject requestPost];
}

- (void)completePostListData:(void(^)(HomeViewController *vc, CollectionViewController *collectionVC, SingleCellCollectionViewController *sigleCollectionVC))completion {
    
    completion(self.homeVC, self.collectionVC, self.singleCollectionVC);
}

@end
