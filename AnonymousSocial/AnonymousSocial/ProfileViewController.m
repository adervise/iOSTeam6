//
//  ProfileViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 2..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "ProfileViewController.h"
#import "LoginPageManager.h"
#import "UserInfomation.h"
#import "LayerCustomUtility.h"
#import "FisrtCollectionViewLayout.h"
#import "CustomProfileCollectionCell.h"
#import "MyCommentViewController.h"
#import "ProfileManager.h"
#import "DetailHomeViewController.h"
#import <UIImageView+WebCache.h>

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

// IBOutlet
@property (weak, nonatomic) IBOutlet UIView *userInfoView;
@property (weak, nonatomic) IBOutlet UIView *userContentsCountView;
@property (weak, nonatomic) IBOutlet UIView *collectionContentsView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthLabel;
@property (weak, nonatomic) IBOutlet UIImageView *genderImage;
@property (weak, nonatomic) IBOutlet UISegmentedControl *contentsSegControl;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


//
@property (weak) MyCommentViewController *commentVC;


@end

@implementation ProfileViewController


#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.collectionViewLayout = [[FisrtCollectionViewLayout alloc] init];
    
    [self setCommentTableViewController];
    
    [LoginPageManager sharedLoginManager].profileNavigationVC = self.navigationController;
    [ProfileManager sharedManager].profileViewController = self;
    
    [self getMyPostData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self setLayoutSubView];
    [self settingForScrollView];
    [self setFrameForChildViewController];
    
    self.userImageView.layer.cornerRadius = self.userImageView.bounds.size.width / 2.0f;
    self.userImageView.clipsToBounds = YES;
}

/*
 
 viewWillAppear에서 사용자의 로그인상태를 체크하여 보이는 화면을 다르게할 수 있도록 하자!!
 
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Data From Server API

- (void)getMyPostData {
    
    [[ProfileManager sharedManager] requestMyPostListData:^(BOOL success, id data) {
      
        if (success) {
            _myPostDataArray = (NSArray *)data;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mainCollectionView reloadData];
            });
        } else {
            
        }
    }];
}


#pragma mark - setting Methods

- (void)setLayoutSubView {
    
    [LayerCustomUtility changeTopBottomBorderLine:self.userContentsCountView];
    [LayerCustomUtility transparentToNavigationBar:self];
    [LayerCustomUtility shadowEffectForCell:self.userInfoView.layer shadowOffset:0.3f];
    [LayerCustomUtility shadowEffectForCell:self.userContentsCountView.layer shadowOffset:0.3f];
    
}
- (void)settingForScrollView {
    
    [self.scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * 2, self.scrollView.bounds.size.height)];
}

- (void)setCommentTableViewController {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Profile" bundle:nil];
    MyCommentViewController *commentVC = [story instantiateViewControllerWithIdentifier:@"MyCommentViewController"];
    [self addChildViewController:commentVC];
    self.commentVC = commentVC;
}

- (void)setFrameForChildViewController {
    
    CGRect commentFrame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    self.commentVC.view.frame = commentFrame;
}

#pragma mark - Button IBAction Method

- (IBAction)onChangeSegControl:(UISegmentedControl *)sender {
    
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        if (sender.selectedSegmentIndex == 0) {
            // 스크롤링을 애니메이션으로 구현
            [UIView animateWithDuration:0.5f animations:^{
                [self.scrollView setContentOffset:CGPointMake(0, 0)];
            }];
            
        } else if (sender.selectedSegmentIndex == 1) {
            
            [UIView animateWithDuration:0.5f animations:^{
                [self.scrollView setContentOffset:CGPointMake(self.scrollView.bounds.size.width, 0)];
            }];
        }
    } else {
        
        NSLog(@"Wrong sender");
    }
}

#pragma mark - Collection View Delegate Method 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.myPostDataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomProfileCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CustomProfileCollectionCell" forIndexPath:indexPath];
    
    cell.postID = [_myPostDataArray[indexPath.row] objectForKey:@"id"];
    [cell.backgroundImageView sd_setImageWithURL:[_myPostDataArray[indexPath.row] objectForKey:@"img_thumbnail"] placeholderImage:nil];
    cell.commentLabel.text = [NSString stringWithFormat:@"%@", [self.myPostDataArray[indexPath.row] objectForKey:@"comments_counts"]];
    cell.likeLabel.text = [NSString stringWithFormat:@"%@", [self.myPostDataArray[indexPath.row] objectForKey:@"like_users_counts"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomProfileCollectionCell *cell = (CustomProfileCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSDictionary *tempDic = [NSDictionary dictionaryWithObject:cell.postID forKey:@"postID"];
    
    [self performSegueWithIdentifier:@"segueToDetail" sender:tempDic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([sender isKindOfClass:[NSDictionary class]]) {
        
        DetailHomeViewController *vc = (DetailHomeViewController *)segue.destinationViewController;
        vc.postID = [sender objectForKey:@"postID"];
    }

}

@end
