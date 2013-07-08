//
//  BurstlyAppLovinAdaptor.h
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#if !__has_feature(objc_arc)
#error These adaptors are designed for an ARC-enabled project. If your project does not use ARC, please be sure to use the -fobjc-arc linker flag on these files.
#endif

#import <Foundation/Foundation.h>

#import "ALSdk.h"
#import "ALSdkSettings.h"
#import "BurstlyAdNetworkAdaptorProtocol.h"

#import "BurstlyApplovinBannerAdaptor.h"
#import "BurstlyApplovinInterstitialAdaptor.h"

@interface BurstlyApplovinAdaptor : NSObject <BurstlyAdNetworkAdaptorProtocol>
@property (strong, nonatomic) ALSdk* sdk;
@property (strong, nonatomic) NSNumber* bannerRefreshRate;

- (NSString*) sdkVersion;

@end
