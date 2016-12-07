//
//  HomVCManager.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HomVCManager : NSObject

+ (instancetype)sharedManager;
- (void)requestPostData;
- (void)completePostData:(id)reponseData;

@end
