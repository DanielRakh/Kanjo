//
//  KJNavigationController.h
//  Kanjo
//
//  Created by Daniel Rakhamimov on 5/1/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ILTranslucentView.h"


@interface KJNavigationController : UINavigationController

@property (nonatomic, strong) UIView *previewView;
@property (nonatomic, strong) ILTranslucentView *blurView;


@end
