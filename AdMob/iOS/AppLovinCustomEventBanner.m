#import "AppLovinCustomEventBanner.h"

@implementation AppLovinCustomEventBanner;

// Will be set by the AdMob SDK.
@synthesize delegate = delegate_;

#pragma mark -
#pragma mark GADCustomEventBanner

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request  {
    
    if (!applovinAd) {
        applovinAd = [[ALAdView alloc] initBannerAd];
    }
    
    [applovinAd setAdLoadDelegate:self];
    [applovinAd setAdDisplayDelegate:self];
    [applovinAd loadNextAd];
}

// This method would be called when a new ad was loaded
-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.delegate customEventBanner:self didReceiveAd:applovinAd];
    }];
}

// This method would be called when an was requested but ad failed to load
-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code {
    NSError *error = [[NSError alloc] init];
    [self.delegate customEventBanner:self didFailAd:error];
}

-(void) ad:(ALAd *) ad wasClickedIn: (UIView *)view {
    [self.delegate customEventBannerWillLeaveApplication:self];
}

-(void) ad:(ALAd *) ad wasHiddenIn:(UIView *)view{}
-(void) ad:(ALAd *) ad wasDisplayedIn:(UIView *)view{}

@end