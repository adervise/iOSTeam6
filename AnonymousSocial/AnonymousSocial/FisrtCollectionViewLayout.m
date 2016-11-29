//
//  FisrtCollectionViewLayout.m
//  AnonymousSocial
//
//  Created by Dabu on 2016. 11. 29..
//  Copyright © 2016년 iosSchool. All rights reserved.
//

#import "FisrtCollectionViewLayout.h"

@interface FisrtCollectionViewLayout ()



@end

@implementation FisrtCollectionViewLayout

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return self;
}

- (CGSize)itemSize {
    
    return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
}

@end
