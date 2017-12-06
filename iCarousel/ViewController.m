//
//  ViewController.m
//  iCarousel
//
//  Created by ZhangJun on 2017/11/6.
//  Copyright © 2017年 wangwang. All rights reserved.
//

#import "ViewController.h"
#import "CarouselFlowLayout.h"
#import "CarouselCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, assign) NSInteger totalItemsCount;

@end

@implementation ViewController

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray arrayWithCapacity:8];
        for (NSInteger i = 1; i < 9; i++) {
            [_imageArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"work%ld.png",i]]];
        }
    }
    return _imageArray;
}

- (NSInteger)totalItemsCount {
    return self.imageArray.count;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addCollectionView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addCollectionView {
    CarouselFlowLayout *flowLayout = [[CarouselFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400) collectionViewLayout:flowLayout];
    self.collectionView.center = self.view.center;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CarouselCollectionViewCell class] forCellWithReuseIdentifier:@"CarouselCollectionViewCell"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.totalItemsCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarouselCollectionViewCell" forIndexPath:indexPath];
    NSInteger itemIndex = indexPath.item % self.imageArray.count;
    cell.imageView.image = self.imageArray[itemIndex];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width - 2*margin, 350);
}

@end
