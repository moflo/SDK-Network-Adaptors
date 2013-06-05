//
//  AppLovinInterstitialCustomEvent.m
//  SimpleAds
//
//  Created by Basil on 3/5/13.
//
//

#import "AppLovinInterstitialCustomEvent.h"

@implementation AppLovinInterstitialCustomEvent

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info
{
    NSLog(@"Requesting AppLovin interstitial...");
    
    ALAdService * adService = [[ALSdk shared] adService];
    [adService loadNextAd: [ALAdSize sizeInterstitial]
                 placedAt: nil
                andNotify: self];
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController
{
    if (_loadedAd)
    {
        UIWindow * window = rootViewController.view.window;
        
        _interstitialAd = [[ALInterstitialAd alloc] initWithFrame:window.frame];
        _interstitialAd.adDisplayDelegate = self;
        [_interstitialAd showOver:rootViewController.view.window andRender:_loadedAd];
    }
    else
    {
        NSLog(@"Failed to show AppLovin interstitial: no ad loaded");
        
        [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
    }
}

#pragma mark -
#pragma mark ALAdLoadDelegate methods
-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    NSLog(@"Successfully loaded AppLovin interstitial.");
    
    // Release existing ad
    [_loadedAd release];
    
    // Save the newly loaded ad
    _loadedAd = ad;
    [_loadedAd retain];
    
    [self.delegate interstitialCustomEvent:self didLoadAd:ad];
}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    NSLog(@"Failed to load AppLovin interstitial: %i", code);
    
    [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
}


#pragma mark ALAdDisplayDelegate methods
-(void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    NSLog(@"AppLovin interstitial was dismissed");
    
    [self.delegate interstitialCustomEventDidDisappear:self];
}


-(void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    NSLog(@"AppLovin interstitial was displayed");    
}

-(void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    NSLog(@"AppLovin interstitial was clicked");
}

- (void)dealloc
{
    _interstitialAd.adDisplayDelegate = nil;

    [_interstitialAd release];
    [_loadedAd release];
    
	[super dealloc];
}

@end
