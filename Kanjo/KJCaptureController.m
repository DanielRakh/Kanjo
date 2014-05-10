//
//  KJCaptureController.m
//  Kanjo
//
//  Created by Daniel Rakhamimov on 5/4/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "KJCaptureController.h"

@interface KJCaptureController ()



@end

@implementation KJCaptureController

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
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
    self.faceView = [[KJFaceView alloc]initWithFrame:self.view.bounds faceMode:FaceModeRegular];
    
}

- (void)circleDidTap:(UITapGestureRecognizer *)tapGesture {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
