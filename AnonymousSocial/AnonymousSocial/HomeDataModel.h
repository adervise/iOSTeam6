//
//  HomeDataModel.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 8..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDataModel : NSObject

+ (instancetype)sharedHomeDataModel;

- (void)putPostData:(id)data;
- (NSArray *)getPostData;

- (void)putNextPostURL:(NSString *)url;
- (NSString *)getNextPostURL;

- (void)appendDataArrayFromArray:(NSArray *)array;

@end
