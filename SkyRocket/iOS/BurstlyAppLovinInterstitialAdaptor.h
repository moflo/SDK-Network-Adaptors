//
//  BurstlyAppLovinInterstitialAdaptor.h
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import <Foundation/Foundation.h>
#import "BurstlyAdInterstitialProtocol.h"
#import "ALAdDisplayDelegate.h"
#import "ALSdk.h"
#import "ALInterstitialAd.h"

@interface BurstlyApplovinInterstitialAdaptor : NSObject <BurstlyAdInterstitialProtocol, ALAdLoadDelegate, ALAdDisplayDelegate>

@property (strong, nonatomic) ALSdk* sdk;
@property (strong, nonatomic) ALInterstitialAd* interstitialObject;
@property (strong, nonatomic) ALAd* lastAd;
@property (strong, nonatomic) NSObject* adaptorLock;

-(id) initWithSdk: (ALSdk*) appLovinSdk;
@end
