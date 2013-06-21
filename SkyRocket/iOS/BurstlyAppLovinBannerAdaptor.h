//
//  BurstlyAppLovinBannerAdaptor.h
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import <Foundation/Foundation.h>
#import "BurstlyAdBannerProtocol.h"
#import "ALSdk.h"
#import "ALAdView.h"
#import "ALAdDisplayDelegate.h"

@interface BurstlyApplovinBannerAdaptor : NSObject <BurstlyAdBannerProtocol, ALAdLoadDelegate, ALAdDisplayDelegate>
@property (strong, nonatomic) ALSdk* sdk;
@property (strong, nonatomic) ALAdView* adView;
@property (strong, nonatomic) NSNumber* bannerRefreshRate;

-(id) initWithSdk: (ALSdk*) appLovinSdk bannerRefreshRate: (NSNumber*) refreshRate;
-(void) loadBannerInBackground;
-(void) cancelBannerLoading;

@end
