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
    self.faceCircle = [self createTestCircle];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(circleDidTap:)];
    [self.faceCircle addGestureRecognizer:tapGesture];
    
    [self.view addSubview:self.faceCircle];
    
}

- (void)circleDidTap:(UITapGestureRecognizer *)tapGesture {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)createTestCircle {
    
    UIView *testCircle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 140, 140)];
    testCircle.layer.backgroundColor = [UIColor clearColor].CGColor;
    testCircle.layer.borderColor = [UIColor redColor].CGColor;
    testCircle.layer.borderWidth = 1.0f;
    testCircle.layer.cornerRadius = testCircle.bounds.size.width/2.0f;
    testCircle.center = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0f);
    return testCircle;
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
