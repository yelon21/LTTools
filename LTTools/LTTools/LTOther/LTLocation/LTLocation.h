//
//  LTLocation.h
//  LocationTest
//
//  Created by yelon on 14-5-5.
//  Copyright (c) 2014年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LTLocation : NSObject

@property(nonatomic,assign,readonly) BOOL located;
@property(nonatomic,assign,readonly) BOOL locateEnable;

@property(nonatomic,strong,readonly) CLPlacemark *currentPlacemark;
@property(nonatomic,strong,readonly) NSString *latitudeBaiDu;//纬度
@property(nonatomic,strong,readonly) NSString *longitudeBaiDu;//经度
@property(nonatomic,strong,readonly) NSString *detailAddress;//详细地址
@property(nonatomic,strong,readonly) NSString *briefAddress;//省|市|区|postalCode
@property(nonatomic,strong,readonly) NSString *city;

+ (id)sharedLocation;
@end
