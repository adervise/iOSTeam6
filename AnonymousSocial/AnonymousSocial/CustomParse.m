//
//  CustomParse.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 8..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CustomParse.h"

@implementation CustomParse

+ (NSString *)convert8601DateToNSDate:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    NSDate *date = [formatter dateFromString:dateString];
    
    NSDateFormatter *resultFormatter = [[NSDateFormatter alloc] init];
    [resultFormatter setDateFormat:@"MM월-dd일 HH:mm"];
    NSString *resultDateString = [resultFormatter stringFromDate:date];
    
    return resultDateString;
}

+ (NSString *)convertLocationString:(id)location {

    if (location == [NSNull null]) {
        
        return @"어딘가";
    } else {
        
        return [NSString stringWithFormat:@"%@", location];
    }
}

+ (NSMutableAttributedString *)parseToContentsString:(NSString *)contentString {
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:nil];
    
    NSArray *matches = [regex matchesInString:contentString options:0 range:NSMakeRange(0, contentString.length)];
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:contentString];
    
    for (NSTextCheckingResult *match in matches) {
        
        NSRange wordRange = [match rangeAtIndex:1];
        //Set Font and TextColor
        UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        [attString addAttribute:NSFontAttributeName value:font range:wordRange];
        [attString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:wordRange];
    }
    
    return attString;
}

@end
