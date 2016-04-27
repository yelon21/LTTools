//
//  YLIOFlowBytes.m
//  ipos
//
//  Created by yelon on 14-12-15.
//
//

#import "LTIOFlowBytes.h"
#include <sys/socket.h>
#include <ifaddrs.h>
#include <net/if.h>
//
#import <mach/mach.h>

@implementation LTIOFlowBytes : NSObject

NSString *LT_bytesToAvaiUnit(double bytes){
    
    if(bytes < 1024.0)     // B
    {
        return [NSString stringWithFormat:@"%0.0fB", bytes];
    }
    else if(bytes >= 1024.0 && bytes < 1024 * 1024) // KB
    {
        return [NSString stringWithFormat:@"%.1fKB", bytes / 1024.0];
    }
    else if(bytes >= 1024 * 1024 && bytes < 1024.0 * 1024.0 * 1024.0)   // MB
    {
        return [NSString stringWithFormat:@"%.2fMB", bytes / (1024.0 * 1024.0)];
    }
    else    // GB
    {
        return [NSString stringWithFormat:@"%.3fGB", bytes / (1024.0 * 1024.0 * 1024.0)];
    }
}

+ (double)LT_getGprs3GFlowIOBytes{
    
    struct ifaddrs *ifa_list= 0, *ifa;
    
    if (getifaddrs(&ifa_list)== -1){
        
        return 0;
    }
    
    double iBytes =0;
    
    double oBytes =0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next){
        
        if (AF_LINK!= ifa->ifa_addr->sa_family){
            
            continue;
        }
        
        if (!(ifa->ifa_flags& IFF_UP) &&!(ifa->ifa_flags& IFF_RUNNING)){
            
            continue;
        }
        
        if (ifa->ifa_data== 0){
            
            continue;
        }
        
        if (!strcmp(ifa->ifa_name,"pdp_ip0")){
            
            struct if_data *if_data = (struct if_data*)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
            
            NSLog(@"%s :iBytes is %f, oBytes is %f",ifa->ifa_name, iBytes, oBytes);
        }
    }
    
    freeifaddrs(ifa_list);
    
    return iBytes + oBytes;
}

+ (double)LT_getInterfaceBytes{
    
    struct ifaddrs *ifa_list = 0, *ifa;
    
    if (getifaddrs(&ifa_list) == -1)
    {
        return 0;
    }
    
    double iBytes = 0;
    double oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next){
        
        if (AF_LINK != ifa->ifa_addr->sa_family)
            
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            
            continue;
        
        if (ifa->ifa_data == 0)
            
            continue;
        
        /* Not a loopback device. */
        
        if (strncmp(ifa->ifa_name, "lo", 2)){
            
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            
            oBytes += if_data->ifi_obytes;
        }
    }
    freeifaddrs(ifa_list);
    return iBytes+oBytes;
}
/////////////////////////////////////
//获取当前任务所占用的内存
+ (double)LT_residentMemory{
    
    struct task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t kerr = task_info(mach_task_self(),
                                   TASK_BASIC_INFO,
                                   (task_info_t)&info,
                                   &size);
    
    if( kerr == KERN_SUCCESS ) {
        
        double resident_size = info.resident_size;
        
        return resident_size;
    } else {
        
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
        return -1.0;
    }
}

// 获取当前设备可用内存(单位：MB）
+ (double)LT_availableMemory{
    
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kerr = host_statistics(mach_host_self(),
                                               HOST_VM_INFO,
                                               (host_info_t)&vmStats,
                                               &infoCount);
    
    if (kerr == KERN_SUCCESS) {
        
        double size = vm_page_size *vmStats.free_count;
        return size;
    }
    else {
        
        NSLog(@"Error with task_info(): %s", mach_error_string(kerr));
        return -1.0;
    }
}
@end
