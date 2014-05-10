//
//  KJViewController.m
//  Kanjo
//
//  Created by Daniel Rakhamimov on 5/1/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "KJMainController.h"
#import "KJNavigationController.h"
#import "FaceCaptureAnimator.h"

@interface KJMainController () <UINavigationControllerDelegate, KJFaceViewDelegate>

@property (nonatomic, strong) KJNavigationController *navController;
@property (nonatomic, strong) FaceCaptureAnimator *animator;


@end

@implementation KJMainController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor clearColor];
    
    self.navController = (KJNavigationController *)self.navigationController;
    self.navigationController.delegate = self;
    
    self.faceView = [[KJFaceView alloc]initWithFrame:self.view.bounds faceMode:FaceModeButton];
    self.faceView.delegate = self;
    [self.view addSubview:self.faceView];
    
    
    self.animator = [[FaceCaptureAnimator alloc]init];
    
    
}


- (void)faceButtonDidTouch:(id)sender {
    
    [self performSegueWithIdentifier:@"faceCaptureSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (IBAction)blurButtonDidTouch:(id)sender {
    
    CGFloat blurAlpha = self.navController.blurView.translucentAlpha == 1.0 ? 0.8 : 1.0;
    [UIView animateWithDuration:0.5
                     animations:^{
                    self.navController.blurView.translucentAlpha = blurAlpha ;
                     }];
}
 */

#pragma mark - Navigation Controller Delegate 

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        self.animator.isPresenting = YES;
    } else if (operation == UINavigationControllerOperationPop) {
        self.animator.isPresenting = NO;
    }
    return self.animator;
}



@end
