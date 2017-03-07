//
//  AppLovinBannerCustomEvent.m
//
//
//  Created by Thomas So on 3/6/17.
//
//

#import "AppLovinBannerCustomEvent.h"
#import "MPLogging.h"

#import <AppLovinSDK/AppLovinSDK.h>

// Use the below import statements if not integrating our SDK as a first-class framework
//#import "ALAdView.h"

@interface AppLovinBannerCustomEvent()<ALAdLoadDelegate, ALAdDisplayDelegate>

@property (nonatomic, strong) ALAdView *adView;

@property (nonatomic, assign) CGRect *size;
@property (nonatomic,   copy) NSString *placement;

@end

@implementation AppLovinBannerCustomEvent

static NSString *const kALMoPubMediationErrorDomain = @"com.applovin.sdk.mediation.mopub.errorDomain";

#pragma mark - MPBannerCustomEvent Overridden Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    MPLogInfo(@"Requesting AppLovin banner of size %@ with info: %@", NSStringFromCGSize(size), info);
    
    // Convert requested size to AppLovin Ad Size
    ALAdSize *adSize = [self appLovinAdSizeFromRequestedSize: size];
    if ( adSize )
    {
        self.size = size;
        self.placement = info[@"placement"];
        
        [[ALSdk shared] setPluginVersion: @"MoPubBanner-1.0"];
        [[ALSdk shared].adService loadNextAd: adSize andNotify: self];
    }
    else
    {
        MPLogInfo(@"Failed to create a AppLovin Banner with invalid size");
        
        NSError *error = [NSError errorWithDomain: kALMoPubMediationErrorDomain code: kALErrorCodeUnableToRenderAd userInfo: nil];
        [self.delegate bannerCustomEvent: self didFailToLoadAdWithError: error];
    }
}

- (BOOL)enableAutomaticImpressionAndClickTracking
{
    return NO;
}

#pragma mark - Dealloc

- (void)dealloc
{
    self.adView = nil;
    self.placement = nil;
}

#pragma mark - AppLovin Ad Load Delegate

- (void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    MPLogDebug(@"Banner did load ad");
    
    self.adView = [[ALAdView alloc] initWithFrame: CGRectMake(0.0f, 0.0f, self.size.width, self.size.height)
                                             size: ad.size
                                              sdk: [ALSdk shared]];
    self.adView.adLoadDelegate = self;
    self.adView.adDisplayDelegate = self;
    
    [self.adView render: ad overPlacement: self.placement];
    
    [self.delegate bannerCustomEvent: self didLoadAd: self.adView];
}

- (void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    MPLogDebug(@"Banner failed to load with error: %d", code);
    
    NSError *error = [NSError errorWithDomain: kALMoPubMediationErrorDomain code: code userInfo: nil];
    [self.delegate bannerCustomEvent: self didFailToLoadAdWithError: error];
    
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    MPLogDebug(@"Banner displayed");
    
    [self.delegate trackImpression];
    [self.delegate bannerCustomEventWillBeginAction: self];
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    MPLogDebug(@"Banner dismissed");
    
    [self.delegate bannerCustomEventDidFinishAction: self];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    MPLogDebug(@"Banner clicked");
    
    [self.delegate trackClick];
    [self.delegate bannerCustomEventWillLeaveApplication: self];
}

#pragma mark - Utility Methods

- (ALAdSize *)appLovinAdSizeFromRequestedSize:(CGSize)size
{
    if ( CGSizeEqualToSize(size, MOPUB_BANNER_SIZE) )
    {
        return [ALAdSize sizeBanner];
    }
    else if ( CGSizeEqualToSize(size, MOPUB_MEDIUM_RECT_SIZE) )
    {
        return [ALAdSize sizeMRec];
    }
    
    return nil;
}

@end
