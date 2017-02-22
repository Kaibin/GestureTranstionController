//
//  PanControllerTransition.h
//  GestureTranstionController
//
//  Created by kaibin on 17/1/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PanControllerTransition : NSObject <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

- (instancetype)initWithViewController:(UIViewController *)vc;


@end
