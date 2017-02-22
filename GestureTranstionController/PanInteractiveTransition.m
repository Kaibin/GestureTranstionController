//
//  PanInteractiveTransition.m
//  GestureTranstionController
//
//  Created by kaibin on 17/1/17.
//

#import "PanInteractiveTransition.h"
#import "CollectionViewController.h"

@interface PanInteractiveTransition ()

@property (nonatomic, assign) BOOL shouldComplete;
@property (nonatomic, weak) UIViewController *presentingVC;
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, strong) UIView *tempView;

@end

@implementation PanInteractiveTransition

-(void)attachPanGestureRecognizerToViewController:(UIViewController *)viewController
{
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void)prepareGestureRecognizerInView:(UIView*)view
{
    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:gesture];
}

- (void)handleGesture:(UIPanGestureRecognizer *)gestureRecognizer
{
    UIView *view = gestureRecognizer.view.superview;
//    CGPoint translation = [gestureRecognizer translationInView:view];
    self.location = [gestureRecognizer locationInView:view];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.interacting = YES;
        [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
    }
    if (self.interacting && gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.location = [gestureRecognizer locationInView:view];
        [self updateInteractiveTransition];
    }
    if (self.interacting && (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state == UIGestureRecognizerStateCancelled)) {
        self.interacting = NO;
        if (gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
            [self cancelInteractiveTransition];
        } else {
            [self finishInteractiveTransition];
        }
    }
}

- (void)startInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    UIViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    fromVC.view.alpha = 0;
    self.tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    UIView *containerView = [self.transitionContext containerView];
    [containerView addSubview:self.tempView];
    self.tempView.frame = fromVC.view.bounds;
}

- (void)updateInteractiveTransition
{
    self.tempView.center = self.location;
}

- (void)cancelInteractiveTransition
{
    NSLog(@"cancelInteractiveTransition");
    UIViewController *fromVC = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [self.transitionContext containerView];
    [UIView animateWithDuration:0.4 animations:^{
        self.tempView.center = containerView.center;
        [self.tempView removeFromSuperview];
        fromVC.view.alpha = 1.0;
    }];
}

- (void)finishInteractiveTransition
{
    NSLog(@"finishInteractiveTransition");
    UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.transform = CGAffineTransformIdentity;
    toVC.view.alpha = 1.0;
    UIView *containerView = [self.transitionContext containerView];
    CollectionViewController *vc = (CollectionViewController *)toVC;
    UIView *itemView = [vc cellForItemAtIndexPath:vc.selectedIndexPath];
    [UIView animateWithDuration:0.4 animations:^{
        self.tempView.frame = [itemView convertRect:itemView.bounds toView:containerView];
    } completion:^(BOOL finished) {
        [self.transitionContext finishInteractiveTransition];
        [self.transitionContext completeTransition:YES];
        [self.tempView removeFromSuperview];
    }];
}

@end
