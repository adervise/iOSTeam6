//
//  MyCommentViewController.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCommentViewController : UIViewController

@property NSArray *myCommentDataArray;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end
