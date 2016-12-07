//
//  SingleCellCollectionViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 29..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "SingleCellCollectionViewController.h"
#import "CustomFlowLayout.h"
#import "HomeVCManager.h"
#import "CustomCellSingleCollectionView.h"

@interface SingleCellCollectionViewController ()



@end

@interface SingleCellCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SingleCellCollectionViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postDataArray = [[NSArray alloc] init];
    [HomeVCManager sharedManager].singleCollectionVC = self;
    
    // Transparent NaviBar
    [self transparentNavigationBar];
    self.mainCollectionView.collectionViewLayout = [[CustomFlowLayout alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setting Methods

- (void)transparentNavigationBar {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - CollectionView DateSource Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.postDataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCellSingleCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textView.text = [self.postDataArray[indexPath.row] objectForKey:@"content"];
    cell.backgroundImageView.image = [UIImage imageNamed:@"loginImage"];
    cell.commentLabel.text = [NSString stringWithFormat:@"%@", [self.postDataArray[indexPath.row] objectForKey:@"comments_counts"]];
    cell.likeLabel.text = [NSString stringWithFormat:@"%@", [self.postDataArray[indexPath.row] objectForKey:@"like_users_counts"]];
    cell.postTimeLabel.text = [NSString stringWithFormat:@"%@", [self.postDataArray[indexPath.row] objectForKey:@"modified_date"]];
    
    return cell;
}

#pragma mark - CollecionView Delegate 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"collecionCell is selected!!");
}


@end
