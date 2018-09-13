//
//  DetectFace.m
//  Detect
//
//  Created by huangshan on 2018/8/27.
//  Copyright © 2018年 huangshan. All rights reserved.
//

#import "DetectFace.h"

float factor = 768.0/960;

@implementation DetectFace

+ (void)detectFace:(UIImage *)image {
        
        NSDate *date = [NSDate date];
        
        //1 将UIImage转换成CIImage
        CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
        
        //缩小图片，默认照片的图片像素很高，需要将图片的大小缩小为我们现实的ImageView的大小，否则会出现识别五官过大的情况
        //        float factor = self.imageView.bounds.size.width/image.size.width;
        ciimage = [ciimage imageByApplyingTransform:CGAffineTransformMakeScale(factor, factor)];
        
        //2.设置人脸识别精度
        NSDictionary* opts = [NSDictionary dictionaryWithObject:
                              CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
        //3.创建人脸探测器
        CIDetector* detector = [CIDetector detectorOfType:CIDetectorTypeFace
                                                  context:nil options:opts];
        //4.获取人脸识别数据
        NSArray* features = [detector featuresInImage:ciimage];
        
        NSLog(@"duration==========================%@", @([[NSDate date] timeIntervalSinceDate:date] * 1000));
        
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //5.分析人脸识别数据
        if (features.count) {
            for (CIFaceFeature *faceFeature in features){
                
                //注意坐标的换算，CIFaceFeature计算出来的坐标的坐标系的Y轴与iOS的Y轴是相反的,需要自行处理
                
                // 标出脸部
                CGFloat faceWidth = faceFeature.bounds.size.width;
                
//                self.faceView.hidden = NO;
//                self.faceView.frame = CGRectMake(faceFeature.bounds.origin.x, self.imageView.bounds.size.height-faceFeature.bounds.origin.y - faceFeature.bounds.size.height, faceFeature.bounds.size.width, faceFeature.bounds.size.height);
                
                // 标出左眼
                if(faceFeature.hasLeftEyePosition) {
//                    self.leftEyeView.hidden = NO;
//                    self.leftEyeView.frame = CGRectMake(faceFeature.leftEyePosition.x-faceWidth*0.15,
//                                                        self.imageView.bounds.size.height-(faceFeature.leftEyePosition.y-faceWidth*0.15)-faceWidth*0.3, faceWidth*0.3, faceWidth*0.3);
//                    self.leftEyeView.layer.cornerRadius = faceWidth*0.15;
                }
                // 标出右眼
                if(faceFeature.hasRightEyePosition) {
//                    self.rightEyeView.hidden = NO;
//                    self.rightEyeView.frame = CGRectMake(faceFeature.rightEyePosition.x-faceWidth*0.15,
//                                                         self.imageView.bounds.size.height-(faceFeature.rightEyePosition.y-faceWidth*0.15)-faceWidth*0.3, faceWidth*0.3, faceWidth*0.3);
//                    self.rightEyeView.layer.cornerRadius = faceWidth*0.15;
                }
                // 标出嘴部
                if(faceFeature.hasMouthPosition) {
//                    self.mouthView.hidden = NO;
//                    self.mouthView.frame = CGRectMake(faceFeature.mouthPosition.x-faceWidth*0.2,
//                                                      self.imageView.bounds.size.height-(faceFeature.mouthPosition.y-faceWidth*0.2)-faceWidth*0.4, faceWidth*0.4, faceWidth*0.4);
//                    self.mouthView.layer.cornerRadius = faceWidth*0.2;
                }
                
                NSLog(@"=======leftEyeClosed=%@=======rightEyeClosed=%@", @(faceFeature.leftEyeClosed), @(faceFeature.rightEyeClosed));
            }
        } else {
//            self.faceView.hidden = YES;
//            self.leftEyeView.hidden = YES;
//            self.rightEyeView.hidden = YES;
//            self.mouthView.hidden = YES;
        }
}

@end
