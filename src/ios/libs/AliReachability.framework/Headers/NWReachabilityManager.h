//
//  SPDYNetworkStatusManager.h
//  SPDY
//
//  Created by 亿刀 on 14-1-9.
//  Copyright (c) 2014年 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NW_NETWOEK_STATUS_NOTIFY @"TBNetworkStatusChangeNotify"

typedef enum {
    NotReachable = 0,
    ReachableViaWiFi,
    ReachableVia2G,
    ReachableVia3G,
    ReachableVia4G
} NetworkStatus;

@interface NWReachabilityManager : NSObject

+ (NWReachabilityManager *)shareInstance;

- (NetworkStatus)currentNetworkStatus;

- (NetworkStatus)preNetworkStatus;

- (NSString *)currentNetworkStatusString;

- (NSString *)currentAPN;

- (NSString *)getWifiSSID;

- (NSString *)getWiFiSSIDMD5;

- (void)updateWifiSSID;

+ (BOOL)configureProxies;



@end
