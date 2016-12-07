//
//  MyCommentViewController.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 6..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "MyCommentViewController.h"
#import "ProfileManager.h"

@interface MyCommentViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyCommentViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [ProfileManager sharedManager].commentViewController = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}

@end
