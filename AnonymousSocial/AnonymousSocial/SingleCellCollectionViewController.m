//
//  SingleCellCollectionViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 29..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "SingleCellCollectionViewController.h"
#import "CustomFlowLayout.h"
#import "CustomCellSingleCollectionView.h"
#import <UIImageView+WebCache.h>
#import "CustomParse.h"
#import "HomeDataModel.h"
#import "HomeVCManager.h"
#import "DetailHomeViewController.h"

@class HomeViewController;

@interface SingleCellCollectionViewController ()

@end

@interface SingleCellCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>

@end

@implementation SingleCellCollectionViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - CollectionView DateSource Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [[[HomeDataModel sharedHomeDataModel] getPostData] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCellSingleCollectionView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *dataArray = [[HomeDataModel sharedHomeDataModel] getPostData];
    
    cell.postID = [dataArray[indexPath.row] objectForKey:@"id"];
    cell.textLabel.text = [dataArray[indexPath.row] objectForKey:@"content"];
    cell.textLabel.attributedText = [CustomParse parseToContentsString:[dataArray[indexPath.row] objectForKey:@"content"]];
    [cell.backgroundImageView sd_setImageWithURL:[dataArray[indexPath.row] objectForKey:@"img_thumbnail"] placeholderImage:nil];
    cell.commentLabel.text = [NSString stringWithFormat:@"%@", [dataArray[indexPath.row] objectForKey:@"comments_counts"]];
    cell.likeLabel.text = [NSString stringWithFormat:@"%@", [dataArray[indexPath.row] objectForKey:@"like_users_counts"]];
    cell.postTimeLabel.text = [CustomParse convert8601DateToNSDate:[dataArray[indexPath.row] objectForKey:@"created_date"]];
    cell.locationLabel.text = [CustomParse convertLocationString:[dataArray[indexPath.row] objectForKey:@"distance"]];
    
    return cell;
}

#pragma mark - CollecionView Delegate 

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCellSingleCollectionView *cell = (CustomCellSingleCollectionView *)[collectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *tempDic = [NSDictionary dictionaryWithObject:cell.postID forKey:@"postID"];
    
    [self performSegueWithIdentifier:@"singleToDetail" sender:tempDic];
}

#pragma mark - ScrollView Delegate Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    BOOL existNextPost = ![[[HomeDataModel sharedHomeDataModel] getNextPostURL] isEqual:[NSNull null]];
    NSInteger indexOfPage = [[HomeDataModel sharedHomeDataModel] getCurrentCellCount];
    
    if (scrollView.contentOffset.x > indexOfPage * scrollView.bounds.size.width && existNextPost) {
        
        [[HomeDataModel sharedHomeDataModel] appendCurrentCellCount:10];
        [[HomeVCManager sharedManager] requestNextPostListData:[[HomeDataModel sharedHomeDataModel] getNextPostURL] completion:^(BOOL success, id data) {
            
            if (success) {
                [[HomeDataModel sharedHomeDataModel] appendDataArrayFromArray:[data objectForKey:@"results"]];
                [[HomeDataModel sharedHomeDataModel] putNextPostURL:[data objectForKey:@"next"]];
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                HomeViewController *homeVC = (HomeViewController *)self.parentViewController;
                [homeVC reloadDataWithNextData];
            } else {
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            }
        }];
    }
}


#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([sender isKindOfClass:[NSDictionary class]]) {
        
        DetailHomeViewController *vc = (DetailHomeViewController *)segue.destinationViewController;
        vc.postID = [sender objectForKey:@"postID"];
    }
}

@end
