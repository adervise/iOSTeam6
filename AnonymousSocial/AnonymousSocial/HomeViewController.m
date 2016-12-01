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

@interface HomeViewController ()<UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate>

// ChildViewControllers
@property (weak) CollectionViewController *collectionViewController;
@property (weak) SingleCellCollectionViewController *singleCollectionViewController;

// IBOulet Property
@property (nonatomic, weak) IBOutlet UITableView *mainTableView;
@property (nonatomic, weak) IBOutlet UIScrollView *mainScrollView;
@property (nonatomic, weak) IBOutlet UISegmentedControl *segControl;

@property (nonatomic, weak) IBOutlet UISwitch *tempSwitch;


@end

@implementation HomeViewController


#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomeViewController __weak *wSelf = self;
    self.tabBarController.delegate = wSelf;
    
    [self settingForScrollView];
    [self setRefreshControl];
    [self setChildViewController];
    [self setFrameCollectionViewCotroller];
    
}

- (void)dealloc {
    
    NSLog(@"HomeVC is dealloc!!!");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    if ([sender isKindOfClass:[UIRefreshControl class]]) {
        
        [self.mainTableView reloadData];
        [sender endRefreshing];
    }
}

#pragma mark - Button Methods

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

//- (void)addLoginViewControllerForChildVC {
//    
//    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
//    LoginPageViewController *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginPageViewController"];
//    
//    CGRect originRect = self.view.frame;
//    [loginVC.view setFrame:originRect];
//    [self addChildViewController:loginVC];
//    
//    [UIView animateWithDuration:1.0f animations:^{
//       
//        [self.view addSubview:loginVC.view];
//        [self.tabBarController.tabBar setUserInteractionEnabled:NO];
//    }];
//}

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
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableCell" forIndexPath:indexPath];
    cell.mainTextLabel.text = @"테스트용 글...";
    cell.backGroundImage.image = [UIImage imageNamed:@"풍경.jpg"];
    
    return cell;
}

#pragma mark - Table View Delegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Cell is selected!!");
}

#pragma mark - TabBarController Delegate Method

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    // 프로필탭을 눌렀을 때 로그인여부를 확인
    if (viewController == tabBarController.viewControllers[3]) {
        
        
        // 로그인상태가 아니면
        if (![UserInfomation sharedUserInfomation].isUserLogin) {
            
            // 얼럿창띄우기
            // 얼럿컨트롤러코드는 항상길다. 따로 클래스를만들어 코드를 간결하게 할 필요가 있을 듯.
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"로그인 상태가 아닙니다." message:@"로그인 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
                UINavigationController *nextVC = (UINavigationController *)[story instantiateViewControllerWithIdentifier:@"LoginNavigationCotroller"];
                [self presentViewController:nextVC animated:YES completion:nil];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:nil];
            
            [alert addAction:okAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            return NO;
        }
        
        /*
         로그인 상태일시
         */
    }
    
    return YES;
}

@end
