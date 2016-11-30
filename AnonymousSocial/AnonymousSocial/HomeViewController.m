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
    [self settingAddChildViewController];
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

- (void)settingAddChildViewController {
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
    if (tabBarController.selectedIndex == 3) {
        
        // 로그인여부확인
        
        /*
         테스트코드
         */
        
        
        // 로그인상태가아닐시 얼럿뷰띄워서 로그인창을 띄우도록 유도
        
    }
    
    return NO;
}

@end
