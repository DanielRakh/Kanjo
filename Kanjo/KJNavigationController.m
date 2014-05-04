//
//  KJNavigationController.m
//  Kanjo
//
//  Created by Daniel Rakhamimov on 5/1/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "KJNavigationController.h"
#import "CameraCaptureManager.h"
#import "ILTranslucentView.h"
#import "KJNavBar.h"

@import AVFoundation;

@interface KJNavigationController ()

@property (nonatomic, strong) CameraCaptureManager *cameraCaptureManager;
@property (nonatomic, strong) ILTranslucentView *blurView;
@property (weak, nonatomic) IBOutlet KJNavBar *navBar;

@end

@implementation KJNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCameraWithManager];
    [self setupBlurView];
    [self.view insertSubview:self.navBar atIndex:3];

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.cameraCaptureManager startCamera];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}



#pragma mark - Camera Setup Methods

-(void)setupCameraWithManager {
    
    self.cameraCaptureManager = [[CameraCaptureManager alloc]init];
    self.previewView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.cameraCaptureManager.previewLayer.frame = self.previewView.bounds;
    [self.previewView.layer addSublayer:self.cameraCaptureManager.previewLayer];
    [self.view addSubview:self.previewView];
    [self.view insertSubview:self.previewView atIndex:0];
    
}

#pragma mark - Blur Methods

-(void)setupBlurView {
    self.blurView = [[ILTranslucentView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.blurView.translucentTintColor = [UIColor clearColor];
    self.blurView.translucentStyle = UIBarStyleBlack;
    self.blurView.backgroundColor = [UIColor clearColor];
    self.blurView.translucentAlpha = 1.0f;
    self.blurView.userInteractionEnabled = YES;
    [self.view addSubview:self.blurView];
    [self.view insertSubview:self.blurView atIndex:1];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
