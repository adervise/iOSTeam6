//
//  RequestObject.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 1..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "RequestObject.h"
#import <AFNetworking.h>
#import "UserInfomation.h"
#import "ProfileManager.h"

@interface RequestObject ()

@property NSString *token;

@property id reponseObjectFromServer;

@end

@implementation RequestObject

+ (void)requestLogin:(NSDictionary *)userInfo completion:(LoginCompletion)completion {
    
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
            completion(NO, nil);
        }
        else {
            NSLog(@"\n\nreponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            completion(YES, responseObject);
        }
    }];
    
    [uploadTask resume];
}

+ (void)requestSignUp:(NSDictionary *)userInfo completion:(LoginCompletion)completion {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:[userInfo objectForKey:@"email"] forKey:@"email"];
    [bodyParameters setObject:[userInfo objectForKey:@"password1"] forKey:@"password1"];
    [bodyParameters setObject:[userInfo objectForKey:@"password2"] forKey:@"password2"];
    [bodyParameters setObject:[userInfo objectForKey:@"age"] forKey:@"age"];
    [bodyParameters setObject:[userInfo objectForKey:@"gender"] forKey:@"gender"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/member/signup/"
                                                                                             parameters:bodyParameters
                                                                              constructingBodyWithBlock:nil error:nil];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\nRequestSignUp task error = %@\n\n", error);
            completion(NO, nil);
        }
        else {
            
            NSLog(@"\n\nreponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            completion(YES, responseObject);
        }
    }];
    [uploadTask resume];
}

+ (void)requestLogout:(NSString *)token completion:(NetworkCompletion)completion {
    
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
            
            completion(NO, nil);
        } else {
            
            completion(YES, responseObject);
        }
    }];
    
    [task resume];
}

+ (void)requestPostList:(NetworkCompletion)completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/post/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n RequestPostList Error\n");
            completion(NO, nil);
            
        } else {
            completion(YES, responseObject);
            NSLog(@"\n RequestPostList success\n");
        }
    }];
    [task resume];
}

+ (void)requestNextPost:(NSString *)nextURL completion:(NetworkCompletion)completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:nextURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\nNextPost Error!!\n");
            completion(NO, nil);
            
        } else {
            NSLog(@"\nSuccessNextPost\n");
            completion(YES, responseObject);
        }
    }];
    
    [task resume];

}

+ (void)requestMyPost:(NSString *)token completion:(NetworkCompletion)completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/post/mylist/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSString *appendToken = @"Token ";
    NSString *resultToken = [appendToken stringByAppendingString:token];
    [request setValue:resultToken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\nMyPost Error\n");
            completion(NO, nil);
        } else {
            NSLog(@"\nMyPost Success\n");
            completion(YES, responseObject);
        }
    }];
    [task resume];
}

+ (void)requestPostDetail:(NSString *)postID completion:(NetworkCompletion)completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlString = @"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/post/";
    NSString *resultString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@/", postID]];
    
    NSURL *url = [NSURL URLWithString:resultString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\nDetail Post Error\n");
            completion(NO, nil);
            
        } else {
            NSLog(@"\nDetail Post Success\n");
            completion(YES, responseObject);
        }
    }];
    
    [task resume];

}

+ (void)requestCommentList:(NSString *)postID completion:(NetworkCompletion)completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSString *urlString = @"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/post/";
    NSString *resultString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@/comment/", postID]];
    
    NSURL *url = [NSURL URLWithString:resultString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\nComment List Error\n");
            completion(NO, nil);
            
        } else {
            NSLog(@"\nComment List Success\n");
            completion(YES, responseObject);
        }
    }];
    
    [task resume];
    
}

+ (void)uploadComment:(NSString *)token postID:(NSString *)postID content:(NSString *)content completion:(NetworkCompletion)completion {
    
    NSString *urlString = @"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/post/";
    NSString *resultString = [urlString stringByAppendingString:[NSString stringWithFormat:@"%@/comment/", postID]];
    NSString *appendToken = @"Token ";
    NSString *resultToken = [appendToken stringByAppendingString:token];
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:content forKey:@"content"];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:resultString
                                                                                             parameters:bodyParameters
                                                                              constructingBodyWithBlock:nil error:nil];
    [request setValue:resultToken forHTTPHeaderField:@"Authorization"];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            
            NSLog(@"\nuploadComment error!\n");
            completion(NO, nil);
        }
        else {
            NSLog(@"\nuploadComment success\n");
            completion(YES, responseObject);
        }
    }];
    [uploadTask resume];
}

+ (void)inserMyPost:(NSString *)token postData:(NSDictionary *)postData {
    
    NSLog(@"postData LOGS!!!! %@",postData);
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:[postData objectForKey:@"content"] forKey:@"content"];
    NSData *contentData = [[postData objectForKey:@"content"] dataUsingEncoding:NSUTF8StringEncoding];
    
    for (NSString *tag in [postData objectForKey:@"hashtags"]) {
        [bodyParameters setObject:tag forKey:@"hashtags"];
    }

    //
//    NSLog(@"%@",hashTagsData);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                    URLString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/post/add/"
                                    parameters:bodyParameters
                                    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                        [formData appendPartWithFormData:contentData name:@"content"];
                                    } error:nil];
    
    NSString *appendToken = @"Token ";
    NSString *resultToken = [appendToken stringByAppendingString:token];
    [request setValue:resultToken forHTTPHeaderField:@"Authorization"];
        
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\nRequestPostUp task error = %@\n\n", error);
            
        }
        else {
            
            NSLog(@"\n\nreponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            
            NSString *token = [responseObject objectForKey:@"key"];
            [[LoginPageManager sharedLoginManager] completeLogin:token];
        }
    }];
    [uploadTask resume];
}

+ (void)inserMyPost:(NSString *)token content:(NSString *)content hashTags:(NSMutableArray *)hashTags backgroundImage:(UIImage *)backgroundImage {
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:content forKey:@"content"];
    [bodyParameters setObject:[NSSet setWithArray:hashTags]  forKey:@"hashtags"];
    NSData *imageData = UIImageJPEGRepresentation(backgroundImage, 0.1);
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                URLString:@"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/post/add/"
                                                                parameters:bodyParameters
                                                                constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                                                                    [formData appendPartWithFileData:imageData
                                                                                                name:@"img"
                                                                                            fileName:@"image.jpeg"
                                                                                            mimeType:@"image/jpeg"];
                                                                 } error:nil];
    
    NSString *appendToken = @"Token ";
    NSString *resultToken = [appendToken stringByAppendingString:token];
    [request setValue:resultToken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"\n\nRequestPostUp task error = %@\n\n", error);
        }
        else {
            
            NSLog(@"\n\nreponse = %@\n\n, reponseObject = %@\n\n", response, responseObject);
            
            NSString *token = [responseObject objectForKey:@"key"];
            [[LoginPageManager sharedLoginManager] completeLogin:token];
        }
    }];
    [uploadTask resume];
}

+ (void)updateUserLocation:(NSString *)token latitude:(NSString *)latitude hardness:(NSString *)hardness {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSMutableDictionary *bodyParameters = [[NSMutableDictionary alloc] init];
    [bodyParameters setObject:latitude forKey:@"latitude"];
    [bodyParameters setObject:hardness forKey:@"hardness"];
    
    NSString *url = @"http://team6-dev.ap-northeast-2.elasticbeanstalk.com/member/update/";
    NSString *urlWithUserID = [url stringByAppendingString:[NSString stringWithFormat:@"%@/", [UserInfomation sharedUserInfomation].userID]];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"PATCH" URLString:urlWithUserID parameters:bodyParameters constructingBodyWithBlock:nil error:nil];
    
    NSString *appendToken = @"Token ";
    NSString *resultToken = [appendToken stringByAppendingString:token];
    [request setValue:resultToken forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
        
            NSLog(@"\nLocationUpdate Error\n");
        }
        else {
            
            NSLog(@"\nLocationUpdate Success\n");
        }
    }];
    [uploadTask resume];
}



@end
