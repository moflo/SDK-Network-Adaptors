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

-(id) initWithSdk: (ALSdk*) appLovinSdk;
-(void) loadBannerInBackground;
-(void) cancelBannerLoading;

@end
