//
//  HomeViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 28..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "CollectionViewController.h"
#import "SingleCellCollectionViewController.h"
#import "UserInfomation.h"
#import "LoginPageViewController.h"
#import "CustomAlertController.h"
#import "LoginPageManager.h"
#import "HomeVCManager.h"
#import <UIImageView+WebCache.h>
#import "CustomParse.h"
#import "HomeDataModel.h"

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate, UIScrollViewDelegate>

// ChildViewControllers
@property (weak) CollectionViewController *collectionViewController;
@property (weak) SingleCellCollectionViewController *singleCollectionViewController;

// IBOulet Property
@property (nonatomic, weak) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segControl;
@property (nonatomic, weak) IBOutlet UISwitch *tempSwitch;

// Cell의 높이
@property CGFloat heightOfCell;

@end

@implementation HomeViewController


#pragma mark - View Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController __weak *wSelf = self;
    self.tabBarController.delegate = wSelf;
    [LoginPageManager sharedLoginManager].homeViewController = self.tabBarController;
    
    [self setRefreshControl];
    [self setChildViewController];
    [self reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self settingForScrollView];
    [self setFrameCollectionViewCotroller];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.mainTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - DataManager


#pragma mark - refresh Table Method

- (void)setRefreshControl {
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    NSAttributedString *stringForRefresh = [[NSAttributedString alloc] initWithString:@"Refreshing...."];
    refresh.attributedTitle = stringForRefresh;
    refresh.tintColor = [UIColor redColor];
    self.mainTableView.refreshControl = refresh;
}

// Refresh 애니메이션이 끝나는 시점과 reload가 끝나는시점이 같지 않다
// 수정요망!!
- (void)refreshTableView:(UIRefreshControl *)sender {
    
    [sender endRefreshing];
    [self.mainTableView reloadData];
}

- (void)reloadData {

    [[HomeVCManager sharedManager] requestPostList:[[UserInfomation sharedUserInfomation] gettingUserToken] completion:^(BOOL success, id data) {
       
        if (success) {
            // 데이터 가져오기 성공시
            [[HomeDataModel sharedHomeDataModel] putPostData:data];
            [[HomeDataModel sharedHomeDataModel] putNextPostURL:[data objectForKey:@"next"]];
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_mainTableView reloadData];
                [_collectionViewController.mainCollectionView reloadData];
                [_singleCollectionViewController.mainCollectionView reloadData];
            });
        } else {
            // 실패시
            
        }
    }];
}


#pragma mark - IBAction Button Methods

- (IBAction)onTouchSegControl:(UISegmentedControl *)sender {
    
    if ([sender isKindOfClass:[UISegmentedControl class]]) {
        if (sender.selectedSegmentIndex == 0) {
            // 스크롤링을 애니메이션으로 구현
            [UIView animateWithDuration:0.5f animations:^{
                [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
            }];
            
        } else if (sender.selectedSegmentIndex == 1) {
            
            [UIView animateWithDuration:0.5f animations:^{
                [self.mainScrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0)];
            }];
        }
        else {
            
            [UIView animateWithDuration:0.5f animations:^{
                [self.mainScrollView setContentOffset:CGPointMake(self.view.bounds.size.width*2, 0)];
            }];
        }
        
    } else {
        
        NSLog(@"Wrong sender");
    }
}

#pragma mark - Setting Method

- (void)settingForTableView {
    
    [self.mainTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)settingForScrollView {
    
    [self.mainScrollView setContentSize:CGSizeMake(self.view.bounds.size.width * 3, self.mainScrollView.bounds.size.height)];
}

- (void)setChildViewController {
    // 스토리보드에서 collectionVC를 가져와서 childVC로 설정
    
    // 첫번째 collectionVC가져오기
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Home" bundle:[NSBundle mainBundle]];
    
    CollectionViewController *collectionVC = (CollectionViewController *)[story instantiateViewControllerWithIdentifier:@"CollectionViewController"];
    [self addChildViewController:collectionVC];
    self.collectionViewController = collectionVC;
    
    // 두번째 collectionVC가져오기
    SingleCellCollectionViewController *singleCollection = (SingleCellCollectionViewController *)[story instantiateViewControllerWithIdentifier:@"SingleCellCollectionViewController"];
    [self addChildViewController:singleCollection];
    self.singleCollectionViewController = singleCollection;
    
}

- (void)setFrameCollectionViewCotroller {
    
    // collectionVC의 rootView의 Frame을 스크롤뷰안에 들어갈 수 있도록 설정
    [self.collectionViewController.view setFrame:CGRectMake(self.view.bounds.size.width, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height)];
    // 스크롤뷰에 콜렉션뷰를 addSubView
    [self.mainScrollView addSubview:self.collectionViewController.view];
    
    [self.singleCollectionViewController.view setFrame:CGRectMake(self.view.bounds.size.width*2, 0, self.mainScrollView.bounds.size.width, self.mainScrollView.bounds.size.height)];
    [self.mainScrollView addSubview:self.singleCollectionViewController.view];
    
}

#pragma mark - Table DataSource Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[HomeDataModel sharedHomeDataModel] getPostData] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableCell" forIndexPath:indexPath];
    NSArray *dataArray = [[HomeDataModel sharedHomeDataModel] getPostData];
    
    cell.mainTextLabel.text = [dataArray[indexPath.row] objectForKey:@"content"];
    [cell.backGroundImage sd_setImageWithURL:[dataArray[indexPath.row] objectForKey:@"img_thumbnail"] placeholderImage:nil];
    cell.commentCountLabel.text = [NSString stringWithFormat:@"%@", [dataArray[indexPath.row] objectForKey:@"comments_counts"]];
    cell.likeCountlabel.text = [NSString stringWithFormat:@"%@", [dataArray[indexPath.row] objectForKey:@"like_users_counts"]];
    cell.postTimeLabel.text = [NSString stringWithFormat:@"%@",[CustomParse convert8601DateToNSDate:[dataArray[indexPath.row] objectForKey:@"modified_date"]]];
    cell.locationLabel.text = [CustomParse convertLocationString:[dataArray[indexPath.row] objectForKey:@"distance"]];

    return cell;
}

#pragma mark - Table View Delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Cell is selected!!");
    
    [self performSegueWithIdentifier:@"homeToDetail" sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _heightOfCell = self.mainTableView.bounds.size.height / 3.0f;
    return _heightOfCell;
}

#pragma mark - ScrollView Delegate Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > [HomeVCManager sharedManager].currentCellCount * _heightOfCell) {
        
        NSLog(@"\n\n\nrequest Next Data\n\n\n");
        // 현재 스크롤의 y오프셋이 currentCellCount * _heightOfCell 보다 커졋을(내릴)경우 다음 데이터를 서버에 요청
        // currentCellCout를 10(서버가 보내주는 데이터의 단위)더해준다.
        [HomeVCManager sharedManager].currentCellCount += 10;
        
        // 서버에 다음 데이터 요청
        [[HomeVCManager sharedManager] requestNextPostListData:[[HomeDataModel sharedHomeDataModel] getNextPostURL] completion:^(BOOL success, id data) {
           
            if (success) {
                
                [[HomeDataModel sharedHomeDataModel] appendDataArrayFromArray:[data objectForKey:@"results"]];
                [[HomeDataModel sharedHomeDataModel] putNextPostURL:[data objectForKey:@"next"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_mainTableView reloadData];
                    [_collectionViewController.mainCollectionView reloadData];
                    [_singleCollectionViewController.mainCollectionView reloadData];
                });
                
            } else {
                
                
            }
        }];
    }
}

#pragma mark - TabBarController Delegate Method

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    // 프로필탭을 눌렀을 때 로그인여부를 확인
    if (viewController == tabBarController.viewControllers[3]) {
        // 로그인상태가 아니면
        if (![UserInfomation sharedUserInfomation].isUserLogin) {
            
            [CustomAlertController showCutomAlert:self type:CustomAlertTypeRequiredLogin];
            return NO;
        }
    }
    return YES;
}

#pragma mark - Segue Method

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

@end
