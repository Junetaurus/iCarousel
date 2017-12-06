//
//  CarouselFlowLayout.m
//  iCarousel
//
//  Created by ZhangJun on 2017/11/6.
//  Copyright © 2017年 wangwang. All rights reserved.
//

#import "CarouselFlowLayout.h"

@implementation CarouselFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, margin , 0, margin);
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visiableRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2;
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
        
        if (!CGRectIntersectsRect(visiableRect, attributes.frame)) continue;
        
        CGFloat distance = fabs(attributes.center.x - centerX);
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        CGFloat scale = fabs(cos(apartScale*M_PI/4));
        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
    }
    
    return array;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    
    CGFloat centerX = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds))/2;
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array  = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat itemCenterX = attributes.center.x;
        
        if (ABS(itemCenterX - centerX) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemCenterX - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end
