//
//  CollectionViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 28..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "FisrtCollectionViewLayout.h"
#import "HomeVCManager.h"
#import <UIImageView+WebCache.h>
#import "CustomParse.h"
#import "HomeDataModel.h"

@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation CollectionViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UIRefreshContol
    [self setRefreshControl];
    
    // CollecionViewFlowLayout
    [self settCustomCollecionFlowLayout];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - CutomCollecionViewFlowLayout

- (void)settCustomCollecionFlowLayout {
    
    self.mainCollectionView.collectionViewLayout = [[FisrtCollectionViewLayout alloc] init];
}

#pragma mark - Refresh CollectionView Data

- (void)setRefreshControl {
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    NSAttributedString *stringForRefresh = [[NSAttributedString alloc] initWithString:@"Refreshing...."];
    refresh.attributedTitle = stringForRefresh;
    refresh.tintColor = [UIColor redColor];
    [refresh addTarget:self action:@selector(reloadDataWithRefreshControl:) forControlEvents:UIControlEventValueChanged];
    [self.mainCollectionView addSubview:refresh];
}

- (void)reloadDataWithRefreshControl:(UIRefreshControl *)sender {
    
    if ([sender isKindOfClass:[UIRefreshControl class]]) {
      
        [self.mainCollectionView reloadData];
        [sender endRefreshing];
    } else
        NSLog(@"Wrong sender");
}

#pragma mark - CollectionView Delegate Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[[HomeDataModel sharedHomeDataModel] getPostData] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    NSArray *dataArray = [[HomeDataModel sharedHomeDataModel] getPostData];
    
    collectionCell.mainTextLabel.text = [dataArray[indexPath.row] objectForKey:@"content"];
    [collectionCell.thumbnailImageView sd_setImageWithURL:[dataArray[indexPath.row] objectForKey:@"img_thumbnail"] placeholderImage:nil];
    collectionCell.commentLabel.text = [NSString stringWithFormat:@"%@", [dataArray[indexPath.row] objectForKey:@"comments_counts"]];
    collectionCell.likeLabel.text = [NSString stringWithFormat:@"%@", [dataArray[indexPath.row] objectForKey:@"like_users_counts"]];
    collectionCell.postTimeLabel.text = [NSString stringWithFormat:@"%@", [CustomParse convert8601DateToNSDate:[dataArray[indexPath.row] objectForKey:@"modified_date"]]];
    
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"collectionCell is selected");
    
    [self performSegueWithIdentifier:@"collectionToDetail" sender:nil];
}

#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

@end
