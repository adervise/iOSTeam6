//
//  SingleCellCollectionViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 29..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "SingleCellCollectionViewController.h"
#import "CustomCollectionViewCell.h"
#import "CustomFlowLayout.h"

@interface SingleCellCollectionViewController ()

@property (nonatomic, weak) IBOutlet UICollectionView *mainCollectionView;

@end

@interface SingleCellCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation SingleCellCollectionViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainCollectionView.collectionViewLayout = [[CustomFlowLayout alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setting Methods

#pragma mark - CollectionView DateSource Method

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}


@end
