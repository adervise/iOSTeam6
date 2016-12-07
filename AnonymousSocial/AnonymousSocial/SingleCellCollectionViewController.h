//
//  SingleCellCollectionViewController.h
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 29..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleCellCollectionViewController : UIViewController

@property (nonatomic, weak) IBOutlet UICollectionView *mainCollectionView;
@property NSArray *postDataArray;

@end
