//
//  HomeVCManager.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "CollectionViewController.h"
#import "SingleCellCollectionViewController.h"

@interface HomeVCManager : NSObject

@property (weak) HomeViewController *homeVC;
@property (weak) CollectionViewController *collectionVC;
@property (weak) SingleCellCollectionViewController *singleCollectionVC;

+ (instancetype)sharedManager;
- (void)completePostListData:(void(^)(HomeViewController *vc, CollectionViewController *collectionVC, SingleCellCollectionViewController *sigleCollectionVC))completion;
- (void)requestPostListData;

@end
