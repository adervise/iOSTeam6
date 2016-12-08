//
//  CustomParse.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 8..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CustomParse.h"

@implementation CustomParse

+ (NSDate *)convert8601DateToNSDate:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
    NSLocale *posix = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [formatter setLocale:posix];
    
    return [formatter dateFromString:dateString];
    
}

+ (NSString *)convertLocationString:(id)location {
    
    if ([location isEqual:0] || location == nil) {
        
        return @"어딘가";
    } else {
        
        return [NSString stringWithFormat:@"%@", location];
    }
}

@end
