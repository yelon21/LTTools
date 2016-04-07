//
//  InstallProcessLV.m
//  LTTools
//
//  Created by yelon on 16/4/7.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "InstallProcessLV.h"
#import "LTInstallProcess.h"

@interface InstallProcessLV ()

@property(nonatomic,strong)LTInstallProcess *installProcess;

@end

@implementation InstallProcessLV

-(LTInstallProcess *)installProcess{

    if (!_installProcess) {
        
        _installProcess = [[LTInstallProcess alloc]initWithBaseView:self.view];
    }
    
    return _installProcess;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    static CGFloat progress = 0.0;
    
    self.installProcess.progress = progress;
    progress = progress+0.01;
}
@end
