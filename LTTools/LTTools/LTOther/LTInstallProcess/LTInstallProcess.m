//
//  LTInstallProcess.m
//  JSDemo
//
//  Created by yelon on 16/3/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTInstallProcess.h"
#import <CoreText/CoreText.h>
@interface LTInstallProcess (){

    CGFloat width;
    CGFloat height;
}

@property(nonatomic,strong) CAShapeLayer *baseLayer;
@property(nonatomic,strong) CAShapeLayer *processLayer;
@property(nonatomic,strong) CAShapeLayer *processTextLayer;

@property(nonatomic,strong) CATextLayer *textLayer1;
@property(nonatomic,strong) CATextLayer *textLayer2;
@end

@implementation LTInstallProcess

- (void)remove{
    
    [self.baseLayer removeFromSuperlayer];
    [self.textLayer1 removeFromSuperlayer];
    [self.textLayer2 removeFromSuperlayer];
}

-(instancetype)initWithBaseView:(UIView *)baseView{

    if (self = [self init]) {
        
//        baseView.clipsToBounds = YES;
        width = CGRectGetWidth(baseView.frame);
        height = CGRectGetHeight(baseView.frame);
        
        self.baseLayer = [[CAShapeLayer alloc]init];
        self.baseLayer.path = [self baseLayerPath];
        [baseView.layer addSublayer:self.baseLayer];
        
        [self initTextLayer];
         self.textLayer1.foregroundColor = [UIColor blackColor].CGColor;
        [baseView.layer addSublayer:self.textLayer1];
        [baseView.layer addSublayer:self.textLayer2];
        
        self.processLayer = [[CAShapeLayer alloc]init];
        self.processLayer.path = [self processLayerPath:1.0];
        
        self.processTextLayer = [[CAShapeLayer alloc]init];
        self.processTextLayer.path = [self processTextLayerPath:1.0];
        
        self.baseLayer.mask = self.processLayer;
        self.textLayer2.mask = self.processTextLayer;
        
        self.baseColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    }
    return self;
}

- (void)initTextLayer{

    self.textLayer1 = [self newTextLayer];
    self.textLayer2 = [self newTextLayer];
}

- (CATextLayer *)newTextLayer{
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    CATextLayer *text = [CATextLayer layer];
    text.string = @"0%";
    [text setFrame:CGRectMake(0, 0, 40, 25)];
    text.position = CGPointMake(width/2.0, height/2.0);
    
//    [text setFont:CTFontCreateWithName((__bridge CFStringRef)[UIFont systemFontOfSize:14.0].fontName,
//                                       [UIFont systemFontOfSize:14.0].pointSize, NULL)];
//    [text setFontSize:[UIFont systemFontOfSize:14.0].pointSize];
    [text setFontSize:20.0];
    text.alignmentMode = kCAAlignmentCenter;
    text.foregroundColor = [UIColor whiteColor].CGColor;
    [text setContentsScale:scale];
    [text setBackgroundColor:[UIColor clearColor].CGColor];
    return text;
}


-(void)setBaseColor:(UIColor *)baseColor{

    self.baseLayer.fillColor = baseColor.CGColor;
//    self.textLayer1.foregroundColor = baseColor.CGColor;
}

- (CGPathRef)baseLayerPath{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0.0, 0.0, width, height)];
    return path.CGPath;
}

- (CGPathRef)processLayerPath:(CGFloat)progress{
    
    NSString *content = [NSString stringWithFormat:@"%d%%",[@(progress*100) intValue]];
    self.textLayer1.string = content;
    self.textLayer2.string = content;
    
    CGFloat angle = M_PI*2.0*progress;
    
    CGFloat radius = sqrt((pow(width, 2)+pow(height, 2)));
    
    CGPoint center = CGPointMake(width/2.0, height/2.0);

    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    [path moveToPoint:center];
    
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0-M_PI_2+angle
                  endAngle:M_PI_2*3
                 clockwise:YES];
   
    return path.CGPath;
}
- (CGPathRef)processTextLayerPath:(CGFloat)progress{
    
    
    CGFloat angle = M_PI*2.0*progress;
    
    CGFloat radius = sqrt((pow(width, 2)+pow(height, 2)));
    
    CGPoint center = CGPointMake(width/2.0, height/2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    
    [path moveToPoint:CGPointMake(20.0, 12.5)];
    
    [path addArcWithCenter:center
                    radius:radius
                startAngle:0-M_PI_2+angle
                  endAngle:M_PI_2*3
                 clockwise:YES];
    
    return path.CGPath;
}

- (CAShapeLayer *)processLayer{
    
    if (!_processLayer) {
        
        _processLayer = [CAShapeLayer layer];
        _processLayer.fillColor = [UIColor colorWithWhite:0.0 alpha:0.3].CGColor;
        _processLayer.lineWidth = 10.0;
        _processLayer.strokeColor = [UIColor greenColor].CGColor;
        _processLayer.fillRule = kCAFillRuleEvenOdd;
    }
    return _processLayer;
}

-(void)setProgress:(CGFloat)progress{

    if (progress>1.0) {
        progress -= 1.0;
    }
    
    self.processLayer.path = [self processLayerPath:progress];
    self.processTextLayer.path = [self processTextLayerPath:progress];
}

@end
