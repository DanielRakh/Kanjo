//
//  KJNavigationController.m
//  Kanjo
//
//  Created by Daniel Rakhamimov on 5/1/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "KJNavigationController.h"
#import "CameraCaptureManager.h"

@import AVFoundation;

@interface KJNavigationController ()

@property (nonatomic, strong) CameraCaptureManager *cameraCaptureManager;

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
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.cameraCaptureManager startCamera];

}



#pragma mark - Camera Setup Methods

-(void)setupCameraWithManager {
    
    self.cameraCaptureManager = [[CameraCaptureManager alloc]init];
    self.previewView = [[UIView alloc]initWithFrame:self.view.bounds];
    self.cameraCaptureManager.previewLayer.frame = self.previewView.bounds;
    [self.previewView.layer addSublayer:self.cameraCaptureManager.previewLayer];
    [self.view addSubview:self.previewView];
    [self.view sendSubviewToBack:self.previewView];
    
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
