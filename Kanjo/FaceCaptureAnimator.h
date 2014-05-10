//
//  FaceCaptureAnimator.h
//  Kanjo
//
//  Created by Daniel Rakhamimov on 5/4/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypePresent,
    AnimationTypeDismiss
};

@interface FaceCaptureAnimator : NSObject <UIViewControllerAnimatedTransitioning>


@property (nonatomic, assign) BOOL isPresenting;
@property (nonatomic, assign) AnimationType animationType;

@end
