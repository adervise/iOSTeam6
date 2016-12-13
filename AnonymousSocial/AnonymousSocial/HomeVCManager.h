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

@interface HomeVCManager : NSObject

@property NSString *nextPostDataURL;

+ (instancetype)sharedManager;

// 제일 처음 데이터리스트 요청
- (void)requestPostList:(NetworkCompletion)completion;

// 다음데이터 요청
- (void)requestNextPostListData:(NSString *)nextURL completion:(NetworkCompletion)completion;

- (void)requestPostDetail:(NSString *)detailURL completion:(NetworkCompletion)completion;
- (void)requestCommentList:(NSString *)postID completion:(NetworkCompletion)completion;

- (void)uploadComment:(NSString *)token postID:(NSString *)postID content:(NSString *)content completion:(NetworkCompletion)completion;

@end
