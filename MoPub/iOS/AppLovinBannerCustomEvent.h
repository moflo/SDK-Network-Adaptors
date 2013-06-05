//
//  AppLovinBannerCustomEvent.h
//  SimpleAds
//
//  Created by Basil on 3/5/13.
//
//

#import "MPBannerCustomEvent.h"

#import "ALAdView.h"

@interface AppLovinBannerCustomEvent : MPBannerCustomEvent<ALAdLoadDelegate> {
    ALAdView * _applovinBannerView;
}


@end
