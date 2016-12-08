//
//  HomeVCManager.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RequestObject.h"

typedef void(^NetworkCompletion)(BOOL success, id data);

@interface HomeVCManager : NSObject

// 3개의 VC가 공유할 currentCellCount
@property NSInteger currentCellCount;
@property NSString *nextPostDataURL;

+ (instancetype)sharedManager;

// 제일 처음 데이터리스트 요청
- (void)requestPostList:(NSString *)token completion:(NetworkCompletion)completion;

// 다음데이터 요청
- (void)requestNextPostListData:(NSString *)nextURL completion:(NetworkCompletion)completion;

@end
