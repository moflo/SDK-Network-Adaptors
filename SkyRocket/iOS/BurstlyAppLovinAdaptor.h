//
//  BurstlyAppLovinAdaptor.h
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import <Foundation/Foundation.h>

#import "ALSdk.h"
#import "ALSdkSettings.h"
#import "BurstlyAdNetworkAdaptorProtocol.h"

#import "BurstlyApplovinBannerAdaptor.h"
#import "BurstlyApplovinInterstitialAdaptor.h"

@interface BurstlyApplovinAdaptor : NSObject <BurstlyAdNetworkAdaptorProtocol>
@property (strong, nonatomic) ALSdk* sdk;

-(id) initWithAppLovinSdkKey: (NSString*) sdkKey;

@end
