//
//  DetailHomeViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 7..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "DetailHomeViewController.h"
#import "DatailTableCell.h"
#import "HomeVCManager.h"
#import <UIImageView+WebCache.h>
#import "CustomParse.h"
#import "LayerCustomUtility.h"
#import "UserInfomation.h"
#import "CustomAlertController.h"

@interface DetailHomeViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UIView *mainContentsView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@property (weak, nonatomic) IBOutlet UIView *inputCommentView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightOfCommentView;

@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;


@property NSArray *commentArray;
@property NSDictionary *detailDic;

@end

@implementation DetailHomeViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBarController.tabBar setHidden:YES];
    [self LayoutOfDetailViewController];
    
    _mainTableView.rowHeight = UITableViewAutomaticDimension;
    _mainTableView.estimatedRowHeight = 50;
//    [self.commentTextView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    [self getPostDetailData];
    [self getCommentData];
    [self addObserverForKeyboard];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    
//    if ([keyPath isEqualToString:@"contentSize"]) {
//        
//        _heightOfCommentView.constant += 30;
//    }
//}

- (void)addObserverForKeyboard {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOriginView:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOriginView:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)changeOriginView:(NSNotification *)notification {
    
    CGRect keyboardFrame = [[notification.userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    if ([notification.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        
        [UIView animateWithDuration:1.0f animations:^{
            [self.view setFrame:CGRectMake(0, -(keyboardFrame.size.height), self.view.bounds.size.width, self.view.bounds.size.height)];
        }];
    }
    else if([notification.name isEqualToString:@"UIKeyboardWillHideNotification"]) {
        
        [UIView animateWithDuration:1.0f animations:^{
            [self.view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        }];
    }
}

#pragma mark - get Detail Data From API 

- (void)getPostDetailData {
    
    [[HomeVCManager sharedManager] requestPostDetail:_postID completion:^(BOOL success, id data) {
        if (success) {
            
            _detailDic = (NSDictionary *)data;
            [self inputDetailData];
        }
    }];
}

- (void)getCommentData {
    
    [[HomeVCManager sharedManager] requestCommentList:_postID completion:^(BOOL success, id data) {
        
        if (success) {
            _commentArray = (NSArray *)[data objectForKey:@"results"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mainTableView reloadData];
            });
        }
    }];
}

- (void)inputDetailData {

    [_mainImageView sd_setImageWithURL:[_detailDic objectForKey:@"img"] placeholderImage:nil];
    _contentTextView.text = [NSString stringWithFormat:@"%@", [_detailDic objectForKey:@"content"]];
    _commentLabel.text = [NSString stringWithFormat:@"%@", [_detailDic objectForKey:@"comments_counts"]];
    _likeLabel.text = [NSString stringWithFormat:@"%@", [_detailDic objectForKey:@"like_users_counts"]];
    _locationLabel.text = [NSString stringWithFormat:@"%@", [CustomParse convertLocationString:[_detailDic objectForKey:@"distance"]]];
    _viewCountLabel.text = [NSString stringWithFormat:@"%@", [_detailDic objectForKey:@"view_counts"]];
    _postTimeLabel.text = [NSString stringWithFormat:@"%@", [CustomParse convert8601DateToNSDate:[_detailDic objectForKey:@"created_date"]]];
}


#pragma mark - Layout Methods

- (void)LayoutOfDetailViewController {
    
    [self transparentNavigationBar];
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0, 0, _infoView.bounds.size.width, 0.5f);
    topBorder.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3].CGColor;
    [_infoView.layer addSublayer:topBorder];
    
    [LayerCustomUtility changeTopBottomBorderLine:_inputCommentView];
}

- (void)transparentNavigationBar {
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

#pragma mark - IBAction 

- (IBAction)onTouchTopButton:(UIButton *)sender {
    
    CGPoint shouldTableViewPoint = CGPointMake(0, 0);
    [UIView animateWithDuration:0.3f animations:^{
        _mainTableView.contentOffset = shouldTableViewPoint;
    }];
}

- (IBAction)onTouchExitCommentTextView:(UIButton *)sender {
    
    _commentTextView.text = nil;
    [_commentTextView resignFirstResponder];
}

- (IBAction)onTouchSendButton:(UIButton *)sender {
    
    [[HomeVCManager sharedManager] uploadComment:[[UserInfomation sharedUserInfomation] gettingUserToken]
                                          postID:_postID content:_commentTextView.text completion:^(BOOL  success, id data) {
        
                                              if (success) {
                                                  [self getCommentData];
                                                  [_commentTextView resignFirstResponder];
                                                  
                                                  CGRect tableViewBounds = _mainTableView.bounds;
                                                  [UIView animateWithDuration:0.5f animations:^{
                                                       _mainTableView.contentOffset = CGPointMake(0, _mainTableView.contentSize.height - tableViewBounds.size.height + 40);
                                                  }];
                                              }
    }];
}

#pragma mark - TableView Datasource Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_commentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DatailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatailTableCell" forIndexPath:indexPath];
    
    cell.contentTextLabel.text = [_commentArray[indexPath.row] objectForKey:@"content"];
    cell.postTimeLabel.text = [CustomParse convert8601DateToNSDate:[_commentArray[indexPath.row] objectForKey:@"created_date"]];
    
    return cell;
}

#pragma mark - TableView Delegate Method

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        NSString *headerString = @"이 글에 달린 댓글들 ";
        return headerString;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 25.0f;
    }
    return 0;
}

#pragma mark - ScrollView Delegate Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat heightOfNavigationBar = self.navigationController.navigationBar.bounds.size.height;
    CGFloat heightOfContentsView = _mainContentsView.bounds.size.height;
    
    if (scrollView.contentOffset.y > heightOfContentsView - heightOfNavigationBar)
        [self.navigationController.navigationBar setHidden:YES];
    else if (scrollView.contentOffset.y < heightOfContentsView - heightOfNavigationBar)
        [self.navigationController.navigationBar setHidden:NO];
}

#pragma mark - TextView Delegate Method

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (![UserInfomation sharedUserInfomation].userLogin) {
        
        [CustomAlertController showCutomAlert:self type:CustomAlertTypeRequiredLogin completion:nil];
        return NO;
    } else {
        
        _commentTextView.text = nil;
        [_exitButton setHidden:NO];
        [_sendButton setHidden:NO];
        return YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {

    _commentTextView.text = @"댓글을 입력하세요.";
    [_exitButton setHidden:YES];
    [_sendButton setHidden:YES];
}

@end
