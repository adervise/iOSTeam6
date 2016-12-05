//
//  RequestObject.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 1..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "RequestObject.h"
#import <AFNetworking.h>
#import "LoginPageManager.h"
#import "UserInfomation.h"



@interface RequestObject ()

@property NSString *token;

@property id reponseObjectFromServer;

@end

@implementation RequestObject

+ (void)requestLogin:(NSDictionary *)userInfo {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:[userInfo objectForKey:@"email"] forKey:@"email"];
    NSData *emailStringData = [[userInfo objectForKey:@"email"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [bodyParameters setObject:[userInfo objectForKey:@"password"] forKey:@"password"];
    NSData *pwStringData = [[userInfo objectForKey:@"password"] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/member/login/"
                                                                                             parameters:bodyParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                                                                                 
                                                                                                 [formData appendPartWithFormData:emailStringData name:@"email"];
                                                                                                 [formData appendPartWithFormData:pwStringData name:@"password"];
                                                                                                 
                                                                                             } error:nil];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\nRequestSignUp task error = %@\n\n", error);
            
        }
        else {
            
            NSLog(@"\n\nreponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            
            NSString *token = [responseObject objectForKey:@"key"];
            [[LoginPageManager sharedLoginManager] completeLogin:token];
        }
    }];
    
    [uploadTask resume];
}

+ (void)requestSignUp:(NSDictionary *)userInfo {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:[userInfo objectForKey:@"email"] forKey:@"email"];
    NSData *emailStringData = [[userInfo objectForKey:@"email"] dataUsingEncoding:NSUTF8StringEncoding];

    [bodyParameters setObject:[userInfo objectForKey:@"password1"] forKey:@"password1"];
    NSData *pwStringData = [[userInfo objectForKey:@"password1"] dataUsingEncoding:NSUTF8StringEncoding];
    
    [bodyParameters setObject:[userInfo objectForKey:@"password2"] forKey:@"password2"];
    NSData *rePwstringData = [[userInfo objectForKey:@"password2"] dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/member/signup/"
                                                                                             parameters:bodyParameters
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                                                                  
                                                                                  
                                                                                  [formData appendPartWithFormData:emailStringData name:@"email"];
                                                                                  [formData appendPartWithFormData:pwStringData name:@"password1"];
                                                                                  [formData appendPartWithFormData:rePwstringData name:@"password2"];
                                                                                  
                                                                              } error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\nRequestSignUp task error = %@\n\n", error);
    
        }
        else {
            
            NSLog(@"\n\nreponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            
            NSString *token = [responseObject objectForKey:@"key"];
            [[LoginPageManager sharedLoginManager] completeLogin:token];
        }
    }];
    [uploadTask resume];
}

+ (void)requestLogout:(NSString *)token {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/member/logout/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *appendToken = @"Token ";
    NSString *resultToken = [appendToken stringByAppendingString:token];
    [request setValue:resultToken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\nLogout process error = %@\n\n", error);
        } else {
            
            NSLog(@"\n\nreponse = %@\n\n,  reponseObject = %@\n\n", response, responseObject);
            
            NSString *token = [responseObject objectForKey:@"key"];
            [[LoginPageManager sharedLoginManager] completeUserLogout:token];
        }
    }];
    
    [task resume];
}

@end
