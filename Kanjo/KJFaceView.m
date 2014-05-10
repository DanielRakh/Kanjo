//
//  KJFaceView.m
//  Facey
//
//  Created by Daniel Rakhamimov on 4/28/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import "KJFaceView.h"
#import "CALayer+UIHelper.h"
#import "UIBezierPath-Fitting.h"

@interface KJFaceView ()

@property (nonatomic, strong) CAShapeLayer *faceShape;
@property (nonatomic, assign, readwrite) FaceMode faceMode;

@end

@implementation KJFaceView

- (instancetype)initWithFrame:(CGRect)frame faceMode:(FaceMode)faceMode {
    
    self = [super initWithFrame:frame];
    if (self) {
        _faceMode = faceMode;
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame faceMode:FaceModeRegular];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}


- (void)commonInit {
    
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    [self createFaceLayer];

}



- (CAGradientLayer *)createFaceWithScale:(CGFloat)scale atPosition:(CGPoint)position {
    UIBezierPath *originalFacePath = [self createFacePath];
    if (scale < 1.0) {
        [originalFacePath applyTransform:CGAffineTransformMakeScale(scale, scale)];
    }
    
    CAShapeLayer *faceShape = [self createShapeLayerWithPath:originalFacePath];
    faceShape.anchorPoint = CGPointMake(0.5,0.5);
    faceShape.bounds = CGPathGetBoundingBox(originalFacePath.CGPath);
    faceShape.lineWidth = 1.0;
    faceShape.allowsEdgeAntialiasing = YES;
    faceShape.rasterizationScale = [UIScreen mainScreen].scale;
    
    CAGradientLayer *faceGradientLayer = [CAGradientLayer orangeToPinkGradient];
    faceGradientLayer.contentsScale = [UIScreen mainScreen].scale;
    faceGradientLayer.bounds = CGRectMake(0, 0, self.faceShape.bounds.size.width, self.faceShape.bounds.size.height);
    faceGradientLayer.anchorPoint = CGPointMake(0.5, 0.5);
    
    faceShape.position = CGPointMake(self.faceGradientLayer.bounds.size.width/2.0f,self.faceGradientLayer.bounds.size.height/2.0f);
    faceGradientLayer.mask = self.faceShape;
    faceGradientLayer.position = position;
    return faceGradientLayer;
    
}


#pragma mark - Helper Methods


- (void)createFaceLayer {
    
    UIBezierPath *originalFacePath = [self createFacePath];
    
    if (self.faceMode == FaceModeButton) {
        [originalFacePath applyTransform:CGAffineTransformMakeScale(0.3, 0.3)];
    }
    
    self.faceShape = [self createShapeLayerWithPath:originalFacePath];
    self.faceShape.anchorPoint = CGPointMake(0.5,0.5);
    self.faceShape.bounds = CGPathGetBoundingBox(originalFacePath.CGPath);
    self.faceShape.lineWidth = 1.0;
    self.faceShape.allowsEdgeAntialiasing = YES;
    self.faceShape.rasterizationScale = [UIScreen mainScreen].scale;
    
    self.faceGradientLayer = [CAGradientLayer orangeToPinkGradient];
    self.faceGradientLayer.contentsScale = [UIScreen mainScreen].scale;
    self.faceGradientLayer.bounds = CGRectMake(0, 0, self.faceShape.bounds.size.width, self.faceShape.bounds.size.height);
    self.faceGradientLayer.anchorPoint = CGPointMake(0.5, 0.5);
    
    self.faceShape.position = CGPointMake(self.faceGradientLayer.bounds.size.width/2.0f,self.faceGradientLayer.bounds.size.height/2.0f);
    self.faceGradientLayer.mask = self.faceShape;
    
    if (self.faceMode == FaceModeButton) {
        self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.faceButton.bounds = CGRectMake(0, 0, self.faceGradientLayer.bounds.size.width, self.faceGradientLayer.bounds.size.height);
        self.faceButton.backgroundColor = [UIColor clearColor];
        self.faceGradientLayer.position = CGPointMake(self.faceButton.bounds.size.width/2.0f,self.faceButton.bounds.size.height/2.0f);

        
        [self.faceButton.layer addSublayer:self.faceGradientLayer];
        self.faceButton.center = CGPointMake(self.bounds.size.width/2.0, CGRectGetHeight(self.bounds) - self.faceButton.bounds.size.height/2.0);
        [self.faceButton addTarget:self action:@selector(faceButtonWasTapped) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:self.faceButton];
        
    } else {
        
        self.faceGradientLayer.position = CGPointMake(self.bounds.size.width/2.0f,self.bounds.size.height/2.0f);
        [self.layer addSublayer:self.faceGradientLayer];

    }
    

}


- (void)faceButtonWasTapped {
    
    if (self.delegate) {
        [self.delegate faceButtonDidTouch:self.faceButton];
    }
}


- (CAGradientLayer *)createGradientLayerWithShapeMask:(CAShapeLayer *)shapeMask {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer orangeToPinkGradient];
    gradientLayer.contentsScale = [UIScreen mainScreen].scale;
    gradientLayer.bounds = CGPathGetBoundingBox(shapeMask.path);
    gradientLayer.mask = shapeMask;
    return gradientLayer;
    
}


- (CAShapeLayer *)createShapeLayerWithPath:(UIBezierPath *)bezPath {
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = bezPath.CGPath;
    shape.contentsScale = [UIScreen mainScreen].scale;
    shape.bounds = CGPathGetBoundingBox(bezPath.CGPath);
    shape.fillColor = [UIColor clearColor].CGColor;
    shape.lineWidth = 1.0;
    shape.strokeColor = [UIColor blackColor].CGColor;
    return shape;
}


-(UIBezierPath *)createFacePath {
    
    CGPoint startingPoint = CGPointMake(0, 58);
    
    CGPoint topLeftCurvePoint = CGPointMake(0, 0);
    CGPoint topLeftCurveControlPoint = CGPointMake(-5, 29);
    
    CGPoint topCurvePoint = CGPointMake(182, 0);
    CGPoint topCurveFirstControlPoint = CGPointMake(30, -90);
    CGPoint topCurveSecondControlPoint = CGPointMake(152, -90);
    
    CGPoint topRightCurvePoint = CGPointMake(182, 58);
    CGPoint topRightCurveControlPoint = CGPointMake(187, 29);
    
    CGPoint midRightCurvePoint = CGPointMake(176, 118);
    CGPoint midRightCurveControlPoint = CGPointMake(194, 62);
    
    CGPoint lowerRightCurvePoint = CGPointMake(154, 178);
    CGPoint lowerRightControlPoint = CGPointMake(173, 148);
    
    CGPoint bottomQuadCurvePoint = CGPointMake(28, 178);
    CGPoint bottomQuardCurveControlPoint = CGPointMake(91, 260);
    
    CGPoint lowerLeftPoint = CGPointMake(6, 118);
    CGPoint lowerLeftControlPoint = CGPointMake(9, 148);
    
    CGPoint midLeftPoint = CGPointMake(0, 58);
    CGPoint midLeftControlPoint = CGPointMake(-12, 62);
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    [aPath moveToPoint:startingPoint];
    [aPath addQuadCurveToPoint:topLeftCurvePoint controlPoint:topLeftCurveControlPoint];
    [aPath addCurveToPoint:topCurvePoint controlPoint1:topCurveFirstControlPoint controlPoint2:topCurveSecondControlPoint];
    [aPath addQuadCurveToPoint:topRightCurvePoint controlPoint:topRightCurveControlPoint];
    [aPath addQuadCurveToPoint:midRightCurvePoint controlPoint:midRightCurveControlPoint];
    [aPath addQuadCurveToPoint:lowerRightCurvePoint controlPoint:lowerRightControlPoint];
    [aPath addQuadCurveToPoint:bottomQuadCurvePoint controlPoint:bottomQuardCurveControlPoint];
    [aPath addQuadCurveToPoint:lowerLeftPoint controlPoint:lowerLeftControlPoint];
    [aPath addQuadCurveToPoint:midLeftPoint controlPoint:midLeftControlPoint];
    [aPath closePath];
    
    return aPath;
    
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
