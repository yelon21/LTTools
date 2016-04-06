//
//  UIImage+LTCommon.m
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "UIImage+LTCommon.h"

@implementation UIImage (LTCommon)
//根据颜色返回图片
+ (UIImage*) lt_imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    
    //        [UIImage imageWithCIImage:[CIImage imageWithColor:[CIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]]];
}

- (UIImage *) lt_imageWithTintColor:(UIColor *)tintColor
{
    return [self lt_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
    
}

- (UIImage *) lt_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode
{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}
//设定大小
- (NSData *)lt_fitImageMaxData:(float)max{
    
    NSData *imageData_ = UIImageJPEGRepresentation(self, 1.0);
    while ([imageData_ length] - max > 0) {
        
        UIImage *image_ = [UIImage imageWithData:imageData_];
        if (image_.size.width>320.0 || image_.size.height>240.0) {
            
            image_ = [self lt_thumbImage:CGSizeMake(320.0, 240.0)];
        }
        imageData_ = UIImageJPEGRepresentation(image_, 0.1);
    }
    
    return imageData_;
    
}
//缩略图
- (UIImage *)lt_thumbImage:(CGSize)size
{
    
    UIImage *newimage = nil;
    
    if (self) {
        
        UIGraphicsBeginImageContext(size);
        
        [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
        
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }
    
    return newimage;
}

//获取图片
+ (UIImage *)lt_imageName:(NSString *)name{
    
    NSUInteger scale = [UIScreen mainScreen].scale;
    switch (scale) {
        case 1:
        {
            
            UIImage *image = [UIImage imageNamed:name scale:1];
            if (image == nil) {
                image = [UIImage imageNamed:name scale:2];
            }
            if (image == nil) {
                image = [UIImage imageNamed:name scale:3];
            }
            return image;
        }
            break;
        case 2:
        {
            
            UIImage *image = [UIImage imageNamed:name scale:2];
            if (image == nil) {
                image = [UIImage imageNamed:name scale:3];
            }
            if (image == nil) {
                image = [UIImage imageNamed:name scale:1];
            }
            return image;
        }
            break;
        default:
        {
            
            UIImage *image = [UIImage imageNamed:name scale:3];
            if (image == nil) {
                image = [UIImage imageNamed:name scale:2];
            }
            if (image == nil) {
                image = [UIImage imageNamed:name scale:1];
            }
            return image;
        }
            break;
    }
}

+ (UIImage *)imageNamed:(NSString *)name scale:(NSUInteger)scale{
    
    NSString *imageName = name;
    
    switch (scale) {
        case 1:
            imageName = [NSString stringWithFormat:@"%@",name];
            break;
        case 2:
            imageName = [NSString stringWithFormat:@"%@@2x",name];
            break;
        default:
            imageName = [NSString stringWithFormat:@"%@@3x",name];
    }
    
    return ImageWithPath([[NSBundle mainBundle]pathForResource:imageName ofType:@"png"]);
}

+ (UIImage *)lt_imageWithPath:(NSString *)imagePath{
    
    return [UIImage imageWithContentsOfFile:imagePath];
}
@end
