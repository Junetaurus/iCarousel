//
//  CarouselCollectionViewCell.m
//  iCarousel
//
//  Created by ZhangJun on 2017/11/6.
//  Copyright © 2017年 wangwang. All rights reserved.
//

#import "CarouselCollectionViewCell.h"

@implementation CarouselCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.contentView.bounds;
}

@end
