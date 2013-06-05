//
//  AppLovinCustomEventBanner.h
//  AppLovin AdMob Mediation
//
//  Created by David Anderson on 11/29/12.
//  Copyright (c) 2012 AppLovin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADCustomEventBanner.h"
#import "GADCustomEventBannerDelegate.h"
#import "GADBannerView.h"
#import "GADBannerViewDelegate.h"
#import "ALAdService.h"
#import "ALAdView.h"

@interface AppLovinCustomEventBanner : NSObject <GADCustomEventBanner, ALAdLoadDelegate, ALAdDisplayDelegate> {
    ALAdView *applovinAd;
}

// This method would be called when a new ad was loaded
-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad;

// This method would be called when an was requested but ad failed to load
-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code;


/**
 * This method is invoked when the ad is clicked from in the view.
 *
 * This method is invoked on the main UI thread.
 *
 * @param ad     Ad that was just clicked. Guranteed not to be null.
 * @param view   Ad view in which the ad was hidden. Guranteed not to be null.
 */
-(void) ad:(ALAd *) ad wasClickedIn: (UIView *)view;

@end