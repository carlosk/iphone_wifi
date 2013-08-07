//
//  SOLStumbler.h
//  iphone.wifiii
//
//  Created by wangjun on 10-12-26.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
#include <dlfcn.h>
@interface SOLStumbler : NSObject {
	NSMutableDictionary  *networks;
	NSMutableArray   *networkDicts;
	void *libHandle;
	void *airportHandle;    
	int (*apple80211Open)(void *);
	int (*apple80211Bind)(void *, NSString *);
	int (*apple80211Close)(void *);
	int (*associate)(void *, NSDictionary*, NSString*);

    int (*apple80211Associate)(void *, NSDictionary*, NSString*);
	int (*apple80211Scan)(void *, NSArray **, void *);
}
- (NSMutableDictionary *)networks;                                                             //returns all 802.11 scanned network(s)-
- (NSMutableArray *)networkDicts;                                                             //returns all 802.11 scanned network(s)
- (NSDictionary *)network:(NSString *) BSSID;                   //return specific 802.11 network by BSSID (MAC Address)
- (void)scanNetworks;
- (int)numberOfNetworks;
- (int)associateToNetwork:(NSString *)SSID withPassword:(NSString *)password;
@end

