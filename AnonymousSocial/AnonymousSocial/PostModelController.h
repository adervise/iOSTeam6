//
//  PostModelController.h
//  AnonymousSocial
//
//  Created by celeste on 2016. 12. 7..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PostModelController : NSObject

- (void)userPost:(NSString *)content hashTags:(NSDictionary *)hashTags backgroundImage:(UIImage *)backgroundImage;


@end
