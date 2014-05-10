//
//  KJFaceView.h
//  Facey
//
//  Created by Daniel Rakhamimov on 4/28/14.
//  Copyright (c) 2014 Daniel Rakhamimov. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FaceMode) {
    FaceModeRegular,
    FaceModeEdit,
    FaceModeButton
};

@protocol KJFaceViewDelegate <NSObject>

- (void)faceButtonDidTouch:(id)sender;

@end

@interface KJFaceView : UIView

@property (nonatomic, strong) UIButton *faceButton;
@property (nonatomic, strong) CAGradientLayer *faceGradientLayer;
@property (nonatomic, weak) id <KJFaceViewDelegate> delegate; 
@property (nonatomic, assign, readonly) FaceMode faceMode;

- (instancetype)initWithFrame:(CGRect)frame faceMode:(FaceMode)faceMode;

- (CAGradientLayer *)createFaceWithScale:(CGFloat)scale atPosition:(CGPoint)position;

@end

