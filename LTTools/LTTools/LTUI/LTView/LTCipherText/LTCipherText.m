//
//  LTCipherText.m
//  YJNew
//
//  Created by yelon on 16/1/12.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTCipherText.h"

static NSInteger cellCount = 6;

@implementation LTCipherText

-(instancetype)init{
    
    if (self = [self initWithFrame:CGRectZero]) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    CGFloat screenW = CGRectGetWidth([[UIScreen mainScreen] bounds]);
    
    if (self = [super initWithFrame:CGRectMake(0.0, 0.0, screenW-60.0, 60.0)]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.boundInsets = UIEdgeInsetsZero;
        
        self.gridBackgroundColor = [UIColor whiteColor];
        self.gridLineColor = [UIColor grayColor];
        self.pointColor = [UIColor darkGrayColor];
        
        _pointsCount = 0;
    }
    return self;
}

-(void)setPointsCount:(NSUInteger)pointsCount{
    
    _pointsCount = pointsCount;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    [self drawGridLine];
    [self drawPoints];
}

- (void)drawPoints{
    
    CGFloat viewW = CGRectGetWidth(self.bounds);
    CGFloat viewH = CGRectGetHeight(self.bounds);
    
    CGFloat left = _boundInsets.left;
    CGFloat top = _boundInsets.top;
    
    CGFloat cellW = (viewW - left - _boundInsets.right)/cellCount;
    CGFloat cellH = MIN(cellW, viewH - top - _boundInsets.bottom);
    
    CGFloat radius = cellH/4;
    
    for (NSInteger i = 0; i < _pointsCount; i++) {
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathAddArc(path, NULL, left+cellW/2.0+cellW*i, top+cellH/2.0, radius, 0.0, M_PI*2, YES);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        
        CGContextSetLineWidth(context, 1);
        
        [self.pointColor setFill];
        
        CGContextAddPath(context, path);
        CGContextDrawPath(context, kCGPathFill);
        CGPathRelease(path);
        
        CGContextRestoreGState(context);
    }
}

- (void)drawGridLine{
    
    NSInteger pointCount = 6;
    
    CGFloat viewW = CGRectGetWidth(self.bounds);
    CGFloat viewH = CGRectGetHeight(self.bounds);
    
    CGFloat left = _boundInsets.left;
    CGFloat top = _boundInsets.top;
    
    CGFloat cellW = (viewW - left - _boundInsets.right)/pointCount;
    CGFloat cellH = MIN(cellW, viewH - top - _boundInsets.bottom);
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathAddRoundedRect(path, NULL, CGRectMake(left, top, cellW*pointCount, cellH), 2.5, 2.5);
    
    for (NSInteger i = 1; i < pointCount; i++) {
        
        CGPathMoveToPoint(path, NULL, left+i*cellW, top);
        CGPathAddLineToPoint(path, NULL, left+i*cellW, top+cellH);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    CGContextSetLineWidth(context, 0.5);
    
    [self.gridLineColor setStroke];
    [self.gridBackgroundColor setFill];
    
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
    
    CGContextRestoreGState(context);
}

@end
