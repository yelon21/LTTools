//
//  YLIOFlowBytes.h
//  ipos
//
//  Created by yelon on 14-12-15.
//
//

#import <Foundation/Foundation.h>

@interface YLIOFlowBytes : NSObject

NSString *bytesToAvaiUnit(int bytes);
int getGprs3GFlowIOBytes();
- (long long int)intgetInterfaceBytes;
///////////
void report_memory(void);
@end
