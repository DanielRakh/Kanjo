//
//  CameraCaptureManager.m
//  BlurPractice
//
//  Created by Daniel Rakhamimov on 11/2/13.
//  Copyright (c) 2013 Daniel Rakhamimov. All rights reserved.
//

#import "CameraCaptureManager.h"

@implementation CameraCaptureManager

- (id)init {
    
    return [self initWithFrontCamera:YES];
}


- (id)initWithFrontCamera:(BOOL)shouldUseFrontCamera {
    
    self = [super init];
    if (self) {
        [self setupCaptureSessionWithFrontCamera:shouldUseFrontCamera];
    }
    return self;
}

- (void)setupCaptureSessionWithFrontCamera:(BOOL)shouldUseFrontCamera {
    if (self.captureSession) {
        return;
    }
    
    self.videoDevice = [self deviceForPosition:shouldUseFrontCamera ? AVCaptureDevicePositionFront : AVCaptureDevicePositionBack];
        
    if (!self.videoDevice) {
        //No video camera on this device.
        return;
    }
    self.captureSession = [[AVCaptureSession alloc]init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    self.videoInput = [[AVCaptureDeviceInput alloc]initWithDevice:self.videoDevice error:nil];
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
    self.stillImageOutput.outputSettings = @{AVVideoCodecKey: AVVideoCodecJPEG, AVVideoQualityKey: @1.0};
    [self.captureSession addOutput:self.stillImageOutput];
    
    if ([self.captureSession canAddInput:self.videoInput]) {
        [self.captureSession addInput:self.videoInput];
    }
    
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
}

- (AVCaptureDevice *)deviceForPosition:(AVCaptureDevicePosition)position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (position == AVCaptureDevicePositionBack) {
            if ([device position] == AVCaptureDevicePositionBack) {
                return device;
            }
        } else if (position == AVCaptureDevicePositionFront) {
            if ([device position] == AVCaptureDevicePositionFront) {
                return device;
            }
        }
    }
    return nil;
}


- (void)startCamera {
    if (self.isRunning){
        return;
    }
    [self.captureSession startRunning];
    self.isRunning = YES;
}

- (void)stopCamera {
    if (!self.isRunning) {
        return;
    }
    [self.captureSession stopRunning];
    self.isRunning = NO;
}

- (void)toggleCamera {
    if (self.captureSession) {
        
        AVCaptureDeviceInput *currentCameraInput = self.captureSession.inputs[0];
        AVCaptureDevice *currentDevice = currentCameraInput.device;
        AVCaptureDevicePosition currentPosition = currentDevice.position;
        
        AVCaptureDevicePosition newPosition = currentPosition == AVCaptureDevicePositionFront ? AVCaptureDevicePositionBack:AVCaptureDevicePositionFront;
        AVCaptureDevice *newDevice = [self deviceForPosition:newPosition];
        
        NSError *error;
        AVCaptureDeviceInput *newDeviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:newDevice error:&error];
        if (error) {
            DLogv(error);
        }
        
        [self.captureSession beginConfiguration];
        [self.captureSession removeInput:currentCameraInput];
        [self.captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
        if ([self.captureSession canAddInput:newDeviceInput]) {
            [self.captureSession addInput:newDeviceInput];
            self.videoInput = newDeviceInput;
        } else {
            [self.captureSession addInput:self.videoInput];
        }
        
        if ([newDevice supportsAVCaptureSessionPreset:AVCaptureSessionPresetPhoto]) {
            [self.captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
        }
        
        if ([newDevice lockForConfiguration:nil]) {
            [newDevice setSubjectAreaChangeMonitoringEnabled:YES];
            [newDevice unlockForConfiguration];
        }
        
        
        [self.captureSession commitConfiguration];
        
        
    }
    
}




- (void)captureImage {
    
    AVCaptureConnection *vc = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];

    typedef void (^ImageBlock)(CMSampleBufferRef imageDataSampleBuffer, NSError *error);
    
    
    ImageBlock imgBlk = ^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (!error) {
            NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            self.imageToReturn = [UIImage imageWithData:data scale:1.0];
            [self.delegate cameraDidCaptureWithImage:self.imageToReturn];
        }
    };
    
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:vc completionHandler:imgBlk];
    
    
}

@end
