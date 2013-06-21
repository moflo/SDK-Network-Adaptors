//
//  BurstlyAppLovinBannerAdaptor.m
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import "BurstlyApplovinBannerAdaptor.h"

@implementation BurstlyApplovinBannerAdaptor
@synthesize delegate, sdk, adView, bannerRefreshRate;

-(id) initWithSdk:(ALSdk *)appLovinSdk bannerRefreshRate: refreshRate
{
    self = [super init];
    if(self)
    {
        sdk = appLovinSdk;
        bannerRefreshRate = refreshRate;
        
        adView = [[ALAdView alloc] initBannerAdWithSdk:sdk];
        [adView setAdDisplayDelegate:self];
    }
    return self;
}

-(void) loadBannerInBackground
{
    NSLog(@"AppLovin Burstly Adaptor .... Loading banner");
    [[sdk adService] loadNextAd:[ALAdSize sizeBanner] placedAt:@"BurstlyApplovinBannerAdaptor" andNotify:self];
}

-(void) cancelBannerLoading
{
    // This method is unnecessary, and not implemented in the AppLovin SDK.
    // We pre-cache ads, so it doesn't make sense to cancel a preloaded ad.
}

-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [adView render:ad];
    [delegate banner:self didLoadAd: adView];
}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    NSError* error = [NSError errorWithDomain:@"BurstlyApplovinBannerAdaptor" code:code userInfo:nil];
    [delegate banner:self didFailToLoadAdWithError:error];
}

-(void) ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [delegate bannerWasClicked:self];
    [delegate bannerWillPresentFullScreen:self];
    [delegate bannerWillLeaveApplication:self];
}

-(void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    // Queue next ad load
    [self queueNextAdLoad];
}

-(void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
}

-(void) queueNextAdLoad
{
    [self performSelector:@selector(loadBannerInBackground) withObject:nil afterDelay: [bannerRefreshRate floatValue]];
}

@end
