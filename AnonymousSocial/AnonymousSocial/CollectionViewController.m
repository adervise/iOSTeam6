//
//  CollectionViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 28..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "CollectionViewController.h"
#import "CustomCollectionViewCell.h"

@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *mainCollectionView;

@end

@implementation CollectionViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setRefreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
 
    collectionCell.mainTextLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return collectionCell;
}

@end
