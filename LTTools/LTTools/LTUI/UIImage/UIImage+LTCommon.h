//
//  UIImage+LTCommon.h
//  YLkit
//
//  Created by yelon on 15/7/19.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ImageNamed(imageName_) [UIImage imageNamed:imageName_]
#define ImageWithPath(imagePath)[UIImage lt_imageWithPath:imagePath]

@interface UIImage (LTCommon)

/**
 *  @author yelon
 *
 *  根据颜色返回相应图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
+ (UIImage*) lt_imageWithColor:(UIColor*)color;
/**
 *  @author yelon
 *
 *  将图片内容转换为相应颜色
 *
 *  @param tintColor 设置的目标颜色
 *
 *  @return 图片
 */
- (UIImage *) lt_imageWithTintColor:(UIColor *)tintColor;
/**
 *  @author yelon
 *
 *  将图片压缩到指定大小之下
 *
 *  @param max 设置的图片最大值
 *
 *  @return NSData类型的图片
 */
- (NSData *)lt_fitImageMaxData:(float)max;
/**
 *  @author yelon
 *
 *  将图片压缩成指定尺寸
 *
 *  @param size 设置的尺寸
 *
 *  @return 图片数据
 */
- (UIImage *)lt_thumbImage:(CGSize)size;

+ (UIImage *)lt_imageName:(NSString *)name;
+ (UIImage *)lt_imageWithPath:(NSString *)imagePath;
@end
