//
//  CollectionViewController.m
//  GestureTranstionController
//
//  Created by kaibin on 17/2/22.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
#import "PanControllerTransition.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


static NSString* kCollectionViewCell = @"kCollectionViewCell";
static NSArray *colorArray;

@interface CollectionViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) PanControllerTransition *customTransition;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (!colorArray) {
        colorArray = @[@0xffe2e4, @0xc7f6ec, @0xcbe7ff, @0xfaead0, @0xfffdd9, @0xb2f2e4, @0xdce1fd, @0xe5dcd1];
    }
    [self initView];
}

- (void)initView
{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCell];
    [self.view addSubview:_collectionView];
}

- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenSize = CGRectGetWidth(self.view.bounds);
    CGSize cellSize = CGSizeMake(screenSize*0.5, screenSize*0.5);
    return cellSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    NSNumber *num = colorArray[indexPath.row%colorArray.count];
    cell.backgroundColor = UIColorFromRGB(num.longLongValue);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    self.selectedIndexPath = indexPath;
    NSNumber *num = colorArray[indexPath.row%colorArray.count];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.view.backgroundColor = UIColorFromRGB(num.longLongValue);
    //这里DetailViewController用UINavigationController包起来以便可以再push ViewController
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    nav.modalPresentationCapturesStatusBarAppearance = YES;//设为YES才能在vc种控制statusbar style
    self.customTransition = [[PanControllerTransition alloc] initWithViewController:vc];
    nav.transitioningDelegate = self.customTransition;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
