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
    
    [self setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.shadowImage = [UIImage new];
    self.translucent = YES;
    [self createNavBarLine];
    
    
    
    //Draw Bottom Nav Bar
//    CAGradientLayer *gradientLayer = [CAGradientLayer drawHorizontalGradientLineWithLength:self.bounds.size.width height:1.0f colors:@[[UIColor kanjoSpicyOrange], [UIColor kanjoSpicyPink]]];
//    gradientLayer.position = CGPointMake(0, self.bounds.size.height - 1.0f);
//    [self.layer addSublayer:gradientLayer];
//    
//    NSString *titleString = @"KANJO";
//    CGSize titleStringSize = [titleString sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"ProximaNova-Light" size:26.0f]}];
//    self.title = [[FXLabel alloc]initWithFrame:CGRectMake(40, 200, titleStringSize.width, titleStringSize.height)];
//    self.title.backgroundColor = [UIColor clearColor];
//    self.title.text = titleString;
//    self.title.font = [UIFont fontWithName:@"ProximaNova-Light" size:26.0f];
//    self.title.center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f+10);
//    self.title.gradientColors = @[[UIColor kanjoSpicyPink],[UIColor kanjoSpicyOrange]];
//    self.title.gradientStartPoint = CGPointMake(0.5, 0);
//    self.title.gradientEndPoint = CGPointMake(0.5, 1);
//    [self addSubview:self.title];
}

- (void)createNavBarLine {
    
    CAShapeLayer *lineShape = [CAShapeLayer layer];
    lineShape.path = [self returnHorizontalLinePath].CGPath;
    lineShape.bounds = CGPathGetPathBoundingBox([self returnHorizontalLinePath].CGPath);
    lineShape.lineWidth = 0.5/[UIScreen mainScreen].scale;
    lineShape.contentsScale = [UIScreen mainScreen].scale;
    lineShape.fillColor = [UIColor clearColor].CGColor;
    lineShape.strokeColor = [UIColor whiteColor].CGColor;
    lineShape.anchorPoint = CGPointMake(0, 0);
    lineShape.position = CGPointMake(0, CGRectGetHeight(self.bounds)-1.0f);
    [self.layer addSublayer:lineShape];
}

- (UIBezierPath *)returnHorizontalLinePath {
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointZero];
    [linePath addLineToPoint:CGPointMake(self.bounds.size.width, 0)];
    return linePath;
    
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
