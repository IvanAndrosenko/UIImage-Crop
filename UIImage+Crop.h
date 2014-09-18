//
//  UIImage+Crop.h
//  Public
//
//  Created by Иван on 29.10.13.
//  Copyright (c) 2013 иван. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Crop)
-(UIImage *)cropImageWithRect:(CGRect)rect;
-(UIImage *)cropImageForLentaButtonsView:(CGSize)size;
-(UIImage *)cropImageMiddle:(CGSize)size;
-(UIImage *)decompressedImage;

@end
