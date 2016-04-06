//
//  NSString+html.m
//  YLkit
//
//  Created by yelon on 15-4-2.
//  Copyright (c) 2015年 yelon. All rights reserved.
//

#import "NSString+html.h"
#import "GTMBase64.h"
@implementation NSString (html)

//编码图片
- (NSString *)htmlForJPGImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    NSString *imageSource = [NSString stringWithFormat:@"data:image/jpg;base64,%@",[imageData base64Encoding]];
    return [NSString stringWithFormat:@"<img src = \"%@\" />", imageSource];
}

@end
