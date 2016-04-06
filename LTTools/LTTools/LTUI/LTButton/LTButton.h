//
//  YLButton.h
//  SSSS
//
//  Created by yelon on 14-12-21.
//  Copyright (c) 2014年 yelon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LayoutType){
    
    LayoutType_TopImage,      //上图
    LayoutType_LeftImage    //左图
};

@interface LTButton : UIButton{

    BOOL scaleEnable;
}
@property(nonatomic,assign)LayoutType layoutType;

- (void)setScaleEnable:(BOOL)enable;
@end
