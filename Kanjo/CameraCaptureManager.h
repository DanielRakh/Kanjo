//
//  CameraCaptureManager.h
//  BlurPractice
//
//  Created by Daniel Rakhamimov on 11/2/13.
//  Copyright (c) 2013 Daniel Rakhamimov. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AVFoundation;

@protocol CameraCaptureMangerDelegate <NSObject>

- (void)cameraDidCaptureWithImage:(UIImage *)capturedImage;

@end

@interface CameraCaptureManager : NSObject
@property (strong, nonatomic) AVCaptureSession *captureSession;
@property (strong, nonatomic) AVCaptureDevice *videoDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *videoInput;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) UIImage *imageToReturn;
@property (assign, nonatomic) BOOL isRunning;
@property (weak, nonatomic) id <CameraCaptureMangerDelegate> delegate;

- (id)initWithFrontCamera:(BOOL)shouldUseFrontCamera;

-(void)startCamera;
-(void)stopCamera;
-(void)toggleCamera;
-(void)captureImage;

@end
