//
//  BurstlyAppLovinInterstitialAdaptor.m
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import "BurstlyApplovinInterstitialAdaptor.h"

@implementation BurstlyApplovinInterstitialAdaptor

@synthesize delegate, sdk, lastAd, interstitialObject, adaptorLock;

- (id) initWithSdk:(ALSdk *)appLovinSdk
{
    self = [super init];
    if (self)
    {
        self.sdk = appLovinSdk;
        
        self.interstitialObject = [[ALInterstitialAd alloc] initInterstitialAdWithSdk: appLovinSdk];
        [self.interstitialObject setAdDisplayDelegate:self];
    }
    return self;
}

- (void)loadInterstitialInBackground
{
    #if DEBUG
    NSLog(@"AppLovin/Burstly Adaptor: Loading interstitial in background.");
    #endif
    
    [[self.sdk adService] loadNextAd:[ALAdSize sizeInterstitial] placedAt:@"BurstlyApplovinInterstitialAdaptor" andNotify:self];
}

- (void)cancelInterstitialLoading
{ 
    // This method is unnecessary, and not implemented in the AppLovin SDK.
    // We pre-cache ads, so it doesn't make sense to cancel a preloaded ad.
}

- (void)presentInterstitial
{
    #if DEBUG
    NSLog(@"AppLovin/Burstly Adaptor: Presenting interstitial.");
    #endif

    @synchronized(adaptorLock)
    {
        [delegate interstitialWillPresentFullScreen:self];
        [interstitialObject showOver:[delegate viewForModalPresentation].window andRender: lastAd];
    }
}

-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    @synchronized(adaptorLock)
    {
        self.lastAd = ad;
    }
    
    [delegate interstitialDidLoadAd:self];
}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    NSError* error = [NSError errorWithDomain:@"BurstlyApplovinInterstitialAdaptor" code:code userInfo:nil];
    [delegate interstitial:self didFailToLoadAdWithError:error];
}

-(void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [delegate interstitialWasClicked:self];
    [delegate interstitialWillLeaveApplication:self];
}

-(void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    /*
    Please note that this is not a typo by AppLovin Engineering,
    rather the method provided by the SkyRocket SDK is misspelled.
    Editing this call to correct their typo will break the adaptor.
    */
    
    [delegate interstitialDidPresentFillScreen:self];
}

-(void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [delegate interstitialDidDismissFullScreen:self];
}

@end
