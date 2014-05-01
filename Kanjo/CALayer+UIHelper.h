//
//  CALayer+UIHelper.h
//  Bumpin'
//
//  Created by Daniel Rakhamimov on 4/20/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIColor+ColorPallete.h"

@interface CALayer (UIHelper)

+ (CAGradientLayer *)drawHorizontalGradientLineWithLength:(CGFloat)length height:(CGFloat)height colors:(NSArray *)colors;
+ (CAGradientLayer *)orangeToPinkGradient;
+ (CAGradientLayer *)pinkToOrangeGradient;

@end
