//
//  PostViewController.h
//  AnonymousSocial
//
//  Created by celeste on 2016. 12. 7..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *postView;
@property NSMutableArray *hashTags;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;

- (IBAction)imageSelect:(id)sender;
- (IBAction)savePost:(id)sender;
- (IBAction)hash:(id)sender;


@end
