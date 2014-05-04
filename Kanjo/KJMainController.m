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

@interface KJMainController () <UINavigationControllerDelegate>

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
    
    self.testCircle = [self createTestCircle];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(circleDidTap:)];
    [self.testCircle addGestureRecognizer:tapGesture];
    
    [self.view addSubview:self.testCircle];
    
    self.navigationController.delegate = self;
    self.animator = [[FaceCaptureAnimator alloc]init];
    
}

- (void)circleDidTap:(UITapGestureRecognizer *)tapGesture {
    [self performSegueWithIdentifier:@"faceCaptureSegue" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)blurButtonDidTouch:(id)sender {
    
    CGFloat blurAlpha = self.navController.blurView.translucentAlpha == 1.0 ? 0.8 : 1.0;
    [UIView animateWithDuration:0.5
                     animations:^{
                    self.navController.blurView.translucentAlpha = blurAlpha ;
                     }];
}


- (UIView *)createTestCircle {
    
    UIView *testCircle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    testCircle.layer.backgroundColor = [UIColor clearColor].CGColor;
    testCircle.layer.borderColor = [UIColor redColor].CGColor;
    testCircle.layer.borderWidth = 1.0f;
    testCircle.layer.cornerRadius = testCircle.bounds.size.width/2.0f;
    testCircle.center = CGPointMake(self.view.bounds.size.width/2.0, CGRectGetHeight(self.view.bounds) - 50);
    return testCircle;
}


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
