//
//  HomeDataModel.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 12. 8..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "HomeDataModel.h"

static NSInteger currentCellCount = 5;

@interface HomeDataModel ()

@property (atomic) NSMutableArray *postDataArray;
@property (atomic) NSString *nextPostListURL;

@end

@implementation HomeDataModel

+ (instancetype)sharedHomeDataModel {
    
    static HomeDataModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        model = [[HomeDataModel alloc] init];
    });
    return model;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _postDataArray = [[NSMutableArray alloc] init];
        _nextPostListURL = [[NSString alloc] init];
    }
    
    return self;
}

- (NSInteger)getCurrentCellCount {
    
    return currentCellCount;
}

- (void)setCurrentCellCount:(NSInteger)count {
    currentCellCount = count;
}

- (void)appendCurrentCellCount:(NSInteger)plusCount {
    
    currentCellCount += plusCount;
}

- (void)putPostData:(id)data {
    
    _postDataArray = (NSMutableArray *)[data objectForKey:@"results"];
}

- (NSArray *)getPostData {
    
    return _postDataArray;
}

- (void)putNextPostURL:(NSString *)url {
    
    _nextPostListURL = url;
}

- (NSString *)getNextPostURL {
    return _nextPostListURL;
}

- (void)appendDataArrayFromArray:(NSArray *)array {
    
    NSMutableArray *tempMutableArray = [NSMutableArray arrayWithArray:_postDataArray];
    [tempMutableArray addObjectsFromArray:array];
    
    _postDataArray = tempMutableArray;
}


@end
