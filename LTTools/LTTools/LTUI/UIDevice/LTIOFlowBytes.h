//
//  YLIOFlowBytes.h
//  ipos
//
//  Created by yelon on 14-12-15.
//
//

#import <Foundation/Foundation.h>

@interface LTIOFlowBytes : NSObject

NSString *LT_bytesToAvaiUnit(double bytes);
+ (double)LT_getGprs3GFlowIOBytes;
+ (double)LT_getInterfaceBytes;
///////////

//获取当前任务所占用的内存
+ (double)LT_residentMemory;
// 获取当前设备可用内存
+ (double)LT_availableMemory;
@end
