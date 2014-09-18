//
//  UIImage+Crop.m
//  Public
//
//  Created by Иван on 29.10.13.
//  Copyright (c) 2013 иван. All rights reserved.
//

#import "UIImage+Crop.h"
#define SCREEN_WIDTH 320.0f
@implementation UIImage (Crop)

-(UIImage *)cropImageWithRect:(CGRect)rect
{
    float kResize = self.size.width/SCREEN_WIDTH;
    
    CGRect cropRect = CGRectMake(rect.origin.x * kResize, rect.origin.y * kResize, rect.size.width * kResize, rect.size.height * kResize);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropImage;
}

-(UIImage *)cropImageForLentaButtonsView:(CGSize)size
{
      float kResize = self.size.width/size.width;
    
    CGRect cropRect = CGRectMake(0,self.size.height - size.height * kResize, size.width * kResize, size.height * kResize);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropImage;
               
}

-(UIImage *)cropImageMiddle:(CGSize)size
{
    float kResize = self.size.width/size.width;
    
    CGRect cropRect = CGRectMake(0,(self.size.height - size.height * kResize)/2, size.width * kResize, size.height * kResize);

    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    UIImage *cropImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropImage;
}

-(UIImage *)decompressedImage
{
    CGImageRef imageRef = self.CGImage;
    CGSize targetSize = CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef));
    
    //next function scale compensation for retina screen
    if ([[UIScreen mainScreen] scale]==2) {
        targetSize = CGSizeMake(targetSize.width/2, targetSize.height/2);
    }
    
    return [self imageByScalingAndCroppingForSize:targetSize];
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    //retina screen
    if ([[UIScreen mainScreen] scale]==2) {
        targetSize = CGSizeMake(targetSize.width*2, targetSize.height*2);
    }
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        //        if (widthFactor > heightFactor)
        //        {
        //            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        //        }
        //        else
        //        {
        //            if (widthFactor < heightFactor)
        //            {
        //                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        //            }
        //        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
