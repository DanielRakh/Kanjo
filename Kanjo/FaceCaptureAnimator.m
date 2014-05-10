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
#import "KJNavigationController.h"

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
    KJMainController *mainController;
    KJCaptureController *captureController;
 
    if (self.animationType == AnimationTypePresent) {
        mainController = (KJMainController *)fromVC;
        captureController = (KJCaptureController *)toVC;
        captureController.faceView.alpha = 0.0;
        mainController.faceView.alpha = 0.0;
    } else if (self.animationType == AnimationTypeDismiss){
        mainController = (KJMainController *)toVC;
        captureController = (KJCaptureController *)fromVC;
    }
    
//    KJNavigationController *navController = (KJNavigationController *)mainController.navigationController;    
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    CAGradientLayer *faceGraident =  [mainController.faceView createFaceWithScale:0.3 atPosition:CGPointMake(containerView.bounds.size.width/2.0, CGRectGetHeight(containerView.bounds) - mainController.faceView.faceButton.bounds.size.height/2.0)];
    [containerView.layer addSublayer:faceGraident];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.6
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         faceGraident.affineTransform = CGAffineTransformMakeScale(3.0, 3.0);
                         faceGraident.position = CGPointMake(containerView.bounds.size.width/2.0, containerView.bounds.size.height/2.0);
                     }
                     completion:^(BOOL finished) {
//                         captureController.faceView.alpha = 1.0;
//                         [faceGraident removeFromSuperlayer];
                         [transitionContext completeTransition:YES];


                     }];
    
    
}

@end
