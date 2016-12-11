//
//  CustomParse.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 8..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomParse : NSObject

+ (NSString *)convert8601DateToNSDate:(NSString *)dateString;
+ (NSString *)convertLocationString:(id)location;
+ (NSMutableAttributedString *)parseToContentsString:(NSString *)contentString;

@end
