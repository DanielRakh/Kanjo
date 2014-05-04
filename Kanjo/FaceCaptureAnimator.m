//
//  FaceCaptureAnimator.m
//  Kanjo
//
//  Created by Daniel Rakhamimov on 5/4/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "FaceCaptureAnimator.h"
#import "KJMainController.h"
#import "KJCaptureController.h"

@implementation FaceCaptureAnimator


// This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
// synchronize with the main animation.

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 1.0;
    
}

// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
//    if (self.isPresenting) {
//        fromVC =  (KJMainController *)fromVC;
//        toVC = (KJCaptureController *)toVC;
//    } else {
//        fromVC = (KJCaptureController *)fromVC;
//        toVC =  (KJMainController *)toVC;
//    }
    
    
    

    KJMainController *mainController = (KJMainController *)fromVC;
    KJCaptureController *captureController = (KJCaptureController *)toVC;
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    captureController.faceCircle.alpha = 0.0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.6
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         mainController.testCircle.transform = CGAffineTransformMakeScale(2.0, 2.0);
                         mainController.testCircle.center = containerView.center;
                     }
                     completion:^(BOOL finished) {
                         captureController.faceCircle.alpha = 1.0;
                         [transitionContext completeTransition:YES];
                     }];
    
    
}

@end
