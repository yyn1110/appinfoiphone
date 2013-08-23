//
//  UIImage+Utils.m
//  KXShow
//
//  Created by xj guo on 11-11-18.
//  Copyright (c) 2011年 kuxing.com. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Decompress)

// Force the UIImage to decompress the image and cache
// http://stackoverflow.com/questions/1815476/cgimage-uiimage-lazily-loading-on-ui-thread-causes-stutter

- (void)decompress {
    const CGImageRef cgImage = [self CGImage];  
	
    const int width = CGImageGetWidth(cgImage);
    const int height = CGImageGetHeight(cgImage);
	
    const CGColorSpaceRef colorspace = CGImageGetColorSpace(cgImage);
    const CGContextRef context = CGBitmapContextCreate(
													   NULL, /* Where to store the data. NULL = don’t care */
													   width, height, /* width & height */
													   8, width * 4, /* bits per component, bytes per row */
													   colorspace, kCGImageAlphaNoneSkipFirst);
	
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgImage);
    CGContextRelease(context);
}

+ (UIImage *)convertImageToGrayScale:(UIImage *)i
{
	const int RED = 1;
    const int GREEN = 2;
    const int BLUE = 3;
    
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, i.size.width * i.scale, i.size.height * i.scale);
    
    int width = imageRect.size.width;
    int height = imageRect.size.height;
    
    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));
    
    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    
    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [i CGImage]);
    
    for(int y = 0; y < height; y++) {
        for(int x = 0; x < width; x++) {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];
            
            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }
    
    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);
    
    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image
                                                 scale:i.scale
                                           orientation:UIImageOrientationUp];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;
}
@end