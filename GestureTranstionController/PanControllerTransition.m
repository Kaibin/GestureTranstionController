//
//  PanControllerTransition.m
//  GestureTranstionController
//
//  Created by kaibin on 17/1/17.
//

#import "PanControllerTransition.h"
#import "PanInteractiveTransition.h"
#import "DetailViewController.h"
#import "CollectionViewController.h"
#import "PanInteractiveTransition.h"

@interface PanControllerTransition ()

@property (nonatomic, assign) BOOL isPresentation;//判断是present还是dismiss
@property (nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) PanInteractiveTransition *gestureTransition;

@end

@implementation PanControllerTransition

- (instancetype)initWithViewController:(UIViewController *)vc
{
    if (self = [super init]) {
        self.gestureTransition = [[PanInteractiveTransition alloc] init];
        [self.gestureTransition attachPanGestureRecognizerToViewController:vc];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source
{
    _isPresentation = YES;
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _isPresentation = NO;
    return self;
}


- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator
{
    return self.gestureTransition.interacting ? self.gestureTransition : nil;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    if (transitionCompleted) {
        UIViewController *toVC = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        [toVC endAppearanceTransition];
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    CGRect finalFrameVC = [transitionContext finalFrameForViewController:toVC];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [toVC beginAppearanceTransition:YES animated:YES];
    
    if (_isPresentation) {
        CollectionViewController *vc = (CollectionViewController *)fromVC;
        UIView *itemView = [vc cellForItemAtIndexPath:vc.selectedIndexPath];
        UIView *tempView = [itemView snapshotViewAfterScreenUpdates:NO];
        tempView.frame = [itemView convertRect:itemView.bounds toView: containerView];
        toVC.view.alpha = 0;
        [containerView addSubview:toVC.view];
        [containerView addSubview:tempView];
        [UIView animateWithDuration:duration animations:^{
            tempView.frame = toVC.view.frame;
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            tempView.hidden = YES;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    } else {
        //这里的lastView就是push时候初始化的那个tempView
        CollectionViewController *vc = (CollectionViewController *)toVC;
        UIView *itemView = [vc cellForItemAtIndexPath:vc.selectedIndexPath];
        UIView *tempView = containerView.subviews.lastObject;
        tempView.hidden = NO;
        [UIView animateWithDuration:duration animations:^{
            tempView.frame = [itemView convertRect:itemView.bounds toView:containerView];
            fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            [tempView removeFromSuperview];
        }];
    }
}

@end
