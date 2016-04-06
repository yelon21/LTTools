//
//  YLLocation.h
//  LocationTest
//
//  Created by yelon on 14-5-5.
//  Copyright (c) 2014年 yelon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLLocation : NSObject

@property(nonatomic,assign,readonly) BOOL located;
@property(nonatomic,assign,readonly) BOOL locateEnable;

@property(nonatomic,retain,readonly) NSString *latitudeStr;//纬度
@property(nonatomic,retain,readonly) NSString *longitudeStr;//经度
@property(nonatomic,retain) NSString *detailAddress;//
@property(nonatomic,retain,readonly) NSString *postalCode;//省|市|区|postalCode
@property(nonatomic,retain,readonly) NSString *cityName;//城市

+ (id)sharedYLLocation;
@end
