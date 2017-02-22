//
//  CollectionViewController.h
//  GestureTranstionController
//
//  Created by kaibin on 17/2/22.
//  Copyright © 2017年 demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController

@property (nonatomic,assign) NSIndexPath* selectedIndexPath;
- (UICollectionViewCell *)cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

