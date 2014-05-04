//
//  KanjoNavBar.m
//  Facey
//
//  Created by Daniel Rakhamimov on 4/27/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "KJNavBar.h"
#import "UIColor+ColorPallete.h"
#import "FXLabel.h"
#import "CALayer+UIHelper.h"

@implementation KJNavBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [self commonInit];
}

- (void)commonInit {
    
    [self setupNavBar];
}


- (void)setupNavBar {
    [self makeNavBarTransparent];
    [self createNavBarLine];
    [self addGradientLabelToNavBar];
}


- (void)addGradientLabelToNavBar {
    
    NSString *titleString = @"KANJO";
    CGSize titleStringSize = [titleString sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Light" size:26.0f]}];
    self.customTitle = [[FXLabel alloc]initWithFrame:CGRectMake(40, 200, titleStringSize.width, titleStringSize.height)];
    self.customTitle.backgroundColor = [UIColor clearColor];
    self.customTitle.text = titleString;
    self.customTitle.font = [UIFont fontWithName:@"ProximaNova-Light" size:26.0f];
    self.customTitle.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f+10);
    self.customTitle.gradientColors = @[[UIColor kanjoSpicyPink],[UIColor kanjoSpicyOrange]];
    self.customTitle.gradientStartPoint = CGPointMake(0.5, 0);
    self.customTitle.gradientEndPoint = CGPointMake(0.5, 1);
    
    self.topItem.title = @"";
    self.topItem.titleView = self.customTitle;
}

- (void)makeNavBarTransparent {
    [self setBackgroundImage:[UIImage new]
               forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];
    self.translucent = YES;
}

- (void)createNavBarLine {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer drawHorizontalGradientLineWithLength:self.bounds.size.width height:1.0f colors:@[[UIColor kanjoSpicyOrange], [UIColor kanjoSpicyPink]]];
    gradientLayer.position = CGPointMake(0, self.bounds.size.height - 1.0f);
    [self.layer addSublayer:gradientLayer];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
