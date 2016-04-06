//
//  LTDefineConstant.h
//  YJNew
//
//  Created by yelon on 16/3/16.
//  Copyright © 2016年 yelon. All rights reserved.
//

#ifndef LTDefineConstant_h
#define LTDefineConstant_h

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
#define LTTextAlignmentCenter NSTextAlignmentCenter
#else
#define LTTextAlignmentCenter UITextAlignmentCenter

typedef NS_ENUM(NSInteger, LTTextAlignment) {
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000

    LTTextAlignmentLeft     = NSTextAlignmentLeft,
    LTTextAlignmentCenter   = NSTextAlignmentCenter,
    LTTextAlignmentRight    =NSTextAlignmentRight,
    LTTextAlignmentJustified = NSTextAlignmentJustified,
    LTTextAlignmentNatural  = NSTextAlignmentNatural,
#else
    LTTextAlignmentLeft = UITextAlignmentLeft,
    LTTextAlignmentCenter = UITextAlignmentCenter,
    LTTextAlignmentRight = UITextAlignmentRight,
}
#endif

#define LTTextAlignment
#endif /* LTDefineConstant_h */

