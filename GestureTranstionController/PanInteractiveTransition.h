//
//  PanInteractiveTransition.h
//  GestureTranstionController
//
//  Created by kaibin on 17/1/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PanInteractiveTransition : NSObject <UIViewControllerInteractiveTransitioning>
@property (nonatomic, assign) BOOL interacting;
- (void)attachPanGestureRecognizerToViewController:(UIViewController*)viewController;

@end
