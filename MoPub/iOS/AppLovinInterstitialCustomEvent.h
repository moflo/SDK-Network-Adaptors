//
//  AppLovinInterstitialCustomEvent.h
//  SimpleAds
//
//  Created by Basil on 3/5/13.
//
//

#import "MPInterstitialCustomEvent.h"

#import "ALInterstitialAd.h"
#import "ALAdService.h"

@interface AppLovinInterstitialCustomEvent : MPInterstitialCustomEvent<ALAdLoadDelegate, ALAdDisplayDelegate> {
    ALInterstitialAd * _interstitialAd;
    ALAd * _loadedAd;
}

@end
