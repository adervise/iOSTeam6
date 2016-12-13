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

@interface PostViewController () <UIImagePickerControllerDelegate>

@property UIImagePickerController *imagePicker;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hashTags = [NSMutableArray array];
    
    PostViewController __weak *wSelf = self;
    _imagePicker = [[UIImagePickerController alloc] init];
    [_imagePicker setDelegate:wSelf];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// save 버튼 눌렀을 때 
- (IBAction)imageSelect:(id)sender {
    
    [_imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *rectImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.backgroundImage setImage:rectImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePost:(id)sender {
    [PostModelController userPost:self.postView.text hashTags:self.hashTags backgroundImage:self.backgroundImage.image];
}

- (IBAction)hash:(id)sender {
    [self decorateTags:self.postView.text];
}

- (NSMutableAttributedString*)decorateTags:(NSString *)stringWithTags{
    
    NSError *error = nil;
    
    //For "Vijay #Apple Dev"
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:&error];
    
    //For "Vijay @Apple Dev"
    //NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@(\\w+)" options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:stringWithTags options:0 range:NSMakeRange(0, stringWithTags.length)];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:stringWithTags];
    
    NSInteger stringLength=[stringWithTags length];

    for (NSTextCheckingResult *match in matches) {
        
        NSRange wordRange = [match rangeAtIndex:1];
        NSString* word = [stringWithTags substringWithRange:wordRange];
        
        //Set Font
        UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
        
        //Set Background Color
        UIColor *backgroundColor=[UIColor yellowColor];
        [attString addAttribute:NSBackgroundColorAttributeName value:backgroundColor range:wordRange];
        
        //Set Foreground Color
        UIColor *foregroundColor=[UIColor blueColor];
        [attString addAttribute:NSForegroundColorAttributeName value:foregroundColor range:wordRange];
        
        NSLog(@"Found tag %@", word);
        [self.hashTags addObject:word];
        NSLog(@"%@",self.hashTags);
    }
    
    self.postView.attributedText = attString;
    return attString;
}

@end
