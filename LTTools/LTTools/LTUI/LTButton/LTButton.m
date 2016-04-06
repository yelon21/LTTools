//
//  YLButton.m
//  SSSS
//
//  Created by yelon on 14-12-21.
//  Copyright (c) 2014年 yelon. All rights reserved.
//

#import "LTButton.h"

@implementation LTButton
@synthesize layoutType;
//-(CGRect)contentRectForBounds:(CGRect)bounds{
//
//    bounds.origin.x = 5.0;
//    bounds.origin.y = 5.0;
//    bounds.size.width -= 10.0;
//    bounds.size.height -= 5.0;
//    return bounds;
//}

-(void)dealloc{

    [self removeObserver:self forKeyPath:@"highlighted"];
}

- (instancetype)init{

    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

//    NSLog(@"change == %@",change);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    
    NSString *title = [self titleForState:UIControlStateNormal];
    if([title isKindOfClass:[NSString class]]&&[title length]>0){
    
        switch (layoutType) {
            case LayoutType_TopImage:
            {
                float height = contentRect.size.height;
                contentRect.size.height = height*0.7;
                return UIEdgeInsetsInsetRect(contentRect, self.imageEdgeInsets);
            }
                break;
            case LayoutType_LeftImage:
            {
                float width = contentRect.size.width;
                float height = contentRect.size.height;
                if (width<height) {
                    
                    return contentRect;
                }
                else{
                    
                    contentRect.size.height = height;
                    contentRect.size.width  = height/2.0;
                    return UIEdgeInsetsInsetRect(contentRect, self.imageEdgeInsets);
                }
            }
                break;
                
            default:
                break;
        }
        return contentRect;
    }
    else{
    
        return contentRect;
    }
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{

    UIImage *image_ = [self imageForState:UIControlStateNormal];
    
    if (image_) {
        
        switch (layoutType) {
            case LayoutType_TopImage:
            {
                float height = contentRect.size.height;
                contentRect.origin.y = height*0.7;
                contentRect.size.height = height*0.3;
                return contentRect;
            }
                break;
            case LayoutType_LeftImage:
            {
                float width = contentRect.size.width;
                float height = contentRect.size.height;
                if (width<height) {
                    
                    return contentRect;
                }
                else{
                    
                    contentRect.origin.x = height/2.0;
                    contentRect.size.width = width-height/2.0;
                    return contentRect;
                }
            }
                break;
                
            default:
                break;
        }
        return contentRect;
    }
    return contentRect;
}

- (void)setScaleEnable:(BOOL)enable{

    scaleEnable = enable;
}

- (void)scaleMin:(BOOL)min{
    
    if (scaleEnable) {
        
        self.transform = min?CGAffineTransformMakeScale(0.9, 0.9):CGAffineTransformIdentity;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    [super touchesBegan:touches withEvent:event];
//    NSLog(@"touchesBegan");
    [self scaleMin:YES];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    [super touchesEnded:touches withEvent:event];
//    NSLog(@"touchesEnded");
    [self scaleMin:NO];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{

    [super touchesCancelled:touches withEvent:event];
//    NSLog(@"touchesCancelled");
    [self scaleMin:NO];
}
@end
