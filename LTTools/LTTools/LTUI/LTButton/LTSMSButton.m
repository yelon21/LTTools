//
//  LTSMSButton.m
//  Egaga
//
//  Created by yelon on 15/9/23.
//  Copyright © 2015年 yelon. All rights reserved.
//

#import "LTSMSButton.h"

@interface LTSMSButton (){
    
    NSInteger seconds;
}

@property(nonatomic,strong) NSDate *startDate;
@property(nonatomic,assign) NSInteger counts;
@end

@implementation LTSMSButton

-(id)init{
    
    self = [self initWithFrame:CGRectZero];
    if (self) {

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12.0];
        self.counts = 10;
        [self resetTime];
    }
    return self;
}

- (void) resetTime
{
//    NSLog(@"resetTime");
    self.enabled = YES;
    seconds = self.counts;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
}

-(void)startTime
{
    
//    NSLog(@"startTime");
    self.enabled = NO;
    
    self.startDate = [NSDate date];
    
    [self timeDown];
}

- (void)timeDown{
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.startDate];
    
    NSTimeInterval deltInterval = seconds - interval;
    
    if (deltInterval>=0.0) {
        
//        NSLog(@"deltInterval == %f",deltInterval);
        [self setTitle:[NSString stringWithFormat:@"%0.0f S",deltInterval]
              forState:UIControlStateDisabled];
        [self performSelector:@selector(timeDown) withObject:nil afterDelay:1.0];
    }
    else{
        
        [self resetTime];
    }
}

@end
