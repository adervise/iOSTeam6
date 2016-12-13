//
//  CustomCollectionViewCell.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 28..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *standradView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *mainTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;


@property NSString *postID;

@end
