//
//  CustomProfileCollectionCell.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 5..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomProfileCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property NSString *postID;

@end
