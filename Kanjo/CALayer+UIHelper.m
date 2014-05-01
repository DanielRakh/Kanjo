//
//  CALayer+UIHelper.m
//  Bumpin'
//
//  Created by Daniel Rakhamimov on 4/20/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "CALayer+UIHelper.h"

@implementation CALayer (UIHelper)

+ (CAGradientLayer *)drawHorizontalGradientLineWithLength:(CGFloat)length height:(CGFloat)height colors:(NSArray *)colors {
    
    NSArray *colorRefArray = [self returnCGColorRefsFromUIColors:colors];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.contentsScale = [UIScreen mainScreen].scale;
    gradientLayer.bounds = CGRectMake(0, 0, length, height);
    gradientLayer.anchorPoint = CGPointMake(0, 0);
    gradientLayer.position = CGPointMake(0, 0);
    gradientLayer.colors = colorRefArray;
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1.0, 0.5);
    return gradientLayer;
    
}

+ (CAGradientLayer *)orangeToPinkGradient {
    
    CAGradientLayer *gradient = [self returnGradientWithStartColor:[UIColor kanjoSpicyOrange] endColor:[UIColor kanjoSpicyPink]];
    return gradient;
}

+ (CAGradientLayer *)pinkToOrangeGradient {
    
    CAGradientLayer *gradient = [self returnGradientWithStartColor:[UIColor kanjoSpicyPink] endColor:[UIColor kanjoSpicyOrange]];
    return gradient;
}


#pragma mark - Private Helpers


+ (CAGradientLayer *)returnGradientWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    
    NSArray *colorRefArray = [self returnCGColorRefsFromUIColors:@[startColor, endColor]];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.contentsScale = [UIScreen mainScreen].scale;
    gradient.anchorPoint = CGPointMake(0, 0);
    gradient.position = CGPointMake(0, 0);
    gradient.colors = colorRefArray;
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1.0, 0.5);
    return gradient;
    
}

+ (NSArray *)returnCGColorRefsFromUIColors:(NSArray *)colors {
    
    NSMutableArray *colorRefArray = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        CGColorRef colorRef = color.CGColor;
        [colorRefArray addObject:(__bridge id)(colorRef)];
    }
    return [colorRefArray copy];
}

@end
