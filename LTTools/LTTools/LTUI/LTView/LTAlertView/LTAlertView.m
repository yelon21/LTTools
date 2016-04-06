//
//  LTAlertView.m
//  DeviceDemo
//
//  Created by yelon on 16/1/8.
//  Copyright © 2016年 yelon. All rights reserved.
//

#import "LTAlertView.h"
#import <UIKit/UIKit.h>

@interface LTAlertView ()<UIAlertViewDelegate,UIActionSheetDelegate>{
    
    UIAlertView *alertV;
    UIActionSheet *actionSheet;
    
    UIAlertController *alertVC;
}

@property(nonatomic,strong)NSString *buttonTitle;
@property(nonatomic,strong)UIViewController *fromVC;
@property(nonatomic,assign)BOOL isEarly8;
@property(nonatomic,assign)BOOL isAlert;
@end

@implementation LTAlertView

- (nullable instancetype)initWithAlertType:(BOOL)isAlert
                                     title:(nullable NSString *)title
                                   message:(nullable NSString *)message
                         cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                         otherButtonTitles:(nullable NSArray *)otherButtonTitles{
    NSLog(@"currentThread:%@,currentThread:%@",[NSThread currentThread],[NSThread mainThread]);
    if (self = [self init]) {
        
        self.isAlert = isAlert;
        self.isEarly8 = [[[UIDevice currentDevice]systemVersion]doubleValue]<8.0;
        
        if (self.isEarly8) {
            
            if (isAlert) {
                
                alertV = [[UIAlertView alloc]initWithTitle:title
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:cancelButtonTitle
                                         otherButtonTitles: nil];
                
                if (otherButtonTitles && [otherButtonTitles isKindOfClass:[NSArray class]]) {
                    
                    for (NSString *buttonTitle in otherButtonTitles) {
                        
                        [alertV addButtonWithTitle:buttonTitle];
                    }
                }
            }
            else{
                
                actionSheet = [[UIActionSheet alloc]initWithTitle:title
                                                         delegate:self
                                                cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil
                                                otherButtonTitles: nil];
                
                if (otherButtonTitles && [otherButtonTitles isKindOfClass:[NSArray class]]) {
                    
                    for (NSString *buttonTitle in otherButtonTitles) {
                        
                        [actionSheet addButtonWithTitle:buttonTitle];
                    }
                }
            }
        }
        else{
            
            alertVC = [UIAlertController alertControllerWithTitle:title
                                                          message:message
                                                   preferredStyle:self.isAlert? UIAlertControllerStyleAlert:UIAlertControllerStyleActionSheet];
            
            if (otherButtonTitles && [otherButtonTitles isKindOfClass:[NSArray class]]) {
                
                for (NSString *buttonTitle in otherButtonTitles) {
                    
                    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:buttonTitle
                                                                          style:UIAlertActionStyleDefault
                                                                        handler:^(UIAlertAction *action) {
                                                                            
                                                                            NSLog(@"action = %@",action.title);
                                                                            self.buttonTitle = action.title;
                                                                            CFRunLoopStop(CFRunLoopGetCurrent());
                                                                        }];
                    [alertVC addAction:otherAction];
                }
            }
            
            if (cancelButtonTitle) {
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                       style:UIAlertActionStyleCancel
                                                                     handler:^(UIAlertAction *action) {
                                                                         NSLog(@"currentThread:%@,currentThread:%@",[NSThread currentThread],[NSThread mainThread]);
                                                                         NSLog(@"action = %@",action.title);
                                                                         self.buttonTitle = action.title;
                                                                         CFRunLoopStop(CFRunLoopGetCurrent());
                                                                     }];
                [alertVC addAction:cancelAction];
            }
        }
    }
    
    return self;
}

- (nullable NSString *)showAlert{
    
    NSLog(@"currentThread:%@,currentThread:%@",[NSThread currentThread],[NSThread mainThread]);
    if (self.isEarly8) {
        
        if (self.isAlert && alertV) {
            
            [alertV show];
            CFRunLoopRun();
            return self.buttonTitle;
        }
        else if (actionSheet){
            
            [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
            CFRunLoopRun();
            return self.buttonTitle;
        }
    }
    else {
        
        if (alertVC) {
            
            if (!self.fromVC) {
                
                self.fromVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            }
            [self.fromVC presentViewController:alertVC
                                      animated:YES
                                    completion:nil];
            CFRunLoopRun();
            return self.buttonTitle;
        }
    }
    
    return nil;
}

-(NSString *)showAlertFromVC:(UIViewController *)fromVC{
    
    self.fromVC = fromVC;
    return [self showAlert];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet_ didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    NSLog(@"currentThread:%@,currentThread:%@",[NSThread currentThread],[NSThread mainThread]);
    self.buttonTitle = [actionSheet_ buttonTitleAtIndex:buttonIndex];
    CFRunLoopStop(CFRunLoopGetCurrent());
}
#pragma mark UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    NSLog(@"currentThread:%@,currentThread:%@",[NSThread currentThread],[NSThread mainThread]);
    self.buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    CFRunLoopStop(CFRunLoopGetCurrent());
}

@end
