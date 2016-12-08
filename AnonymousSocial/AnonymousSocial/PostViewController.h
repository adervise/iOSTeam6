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


- (IBAction)savePost:(id)sender;


@end
