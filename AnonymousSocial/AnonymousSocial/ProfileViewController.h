//
//  ProfileViewController.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 2..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property NSArray *myPostDataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *mainCollectionView;

- (void)setLayoutSubView;

@end
