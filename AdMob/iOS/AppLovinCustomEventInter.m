#import "AppLovinCustomEventInter.h"

@implementation AppLovinCustomEventInter;

// Will be set by the AdMob SDK.
@synthesize delegate = delegate_;

#pragma mark -
#pragma mark GADCustomEventBanner

-(void) presentFromRootViewController:(UIViewController *)rootViewController
{
    [[ALInterstitialAd shared] showOver:rootViewController.view.window andRender:appLovinAd];
}

- (void)requestInterstitialAdWithParameter:(NSString *)serverParameter label:(NSString *)serverLabel request:(GADCustomEventRequest *)request
{
    [[[ALSdk shared] adService] loadNextAd:[ALAdSize sizeInterstitial] placedAt:@"AdMobMediation" andNotify:self];
}

// This method would be called when a new ad was loaded
-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad {
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        appLovinAd = ad;
        [self.delegate customEventInterstitial:self didReceiveAd:appLovinAd];
    }];
}

// This method would be called when an was requested but ad failed to load
-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code {
    NSError *error = [[NSError alloc] init];
    [self.delegate customEventInterstitial:self didFailAd:error];
}

-(void) ad:(ALAd *) ad wasClickedIn: (UIView *)view {}
-(void) ad:(ALAd *) ad wasHiddenIn:(UIView *)view{}
-(void) ad:(ALAd *) ad wasDisplayedIn:(UIView *)view{}

@end