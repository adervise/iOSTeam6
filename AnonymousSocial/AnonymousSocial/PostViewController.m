//
//  PostViewController.m
//  AnonymousSocial
//
//  Created by celeste on 2016. 12. 7..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "PostViewController.h"
#import "PostModelController.h"
#import "RequestObject.h"
#import "CustomAlertController.h"
#import "UserInfomation.h"

@interface PostViewController ()

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)savePost:(id)sender {

    PostModelController *post = [[PostModelController alloc] init];
    [post userPost:self.postView.text hashTags:nil backgroundImage:nil];
//    [PostModelController userPost:self.postView.text hashTags:nil backgroundImage:nil];

}




@end
