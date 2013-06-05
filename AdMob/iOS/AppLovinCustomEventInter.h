//
//  AppLovinCustomEventBanner.h
//  AppLovin AdMob Mediation
//
//  Created by David Anderson on 11/29/12.
//  Copyright (c) 2012 AppLovin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADCustomEventInterstitial.h"
#import "GADCustomEventInterstitialDelegate.h"
#import "GADInterstitial.h"
#import "GADInterstitialDelegate.h"
#import "ALAdService.h"
#import "ALInterstitialAd.h"

@interface AppLovinCustomEventInter : NSObject <GADCustomEventInterstitial, ALAdLoadDelegate, ALAdDisplayDelegate> {
    ALInterstitialAd *appLovinInter;
    ALAd *appLovinAd;
}

@end