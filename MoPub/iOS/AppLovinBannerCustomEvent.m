//
//  AppLovinBannerCustomEvent.m
//
//
//  Created by Thomas So on 3/6/17.
//
//

#import "AppLovinBannerCustomEvent.h"
#import <AppLovinSDK/AppLovinSDK.h>

// Use the below import statements if not integrating our SDK as a first-class framework
//#import "ALAdView.h"

@interface AppLovinBannerCustomEvent()<ALAdLoadDelegate, ALAdDisplayDelegate>

@property (nonatomic, strong) ALAdView *adView;

@property (nonatomic, assign) CGRect *size;
@property (nonatomic,   copy) NSString *placement;

@end

@implementation AppLovinBannerCustomEvent

static const BOOL kALLoggingEnabled = YES;
static NSString *const kALMoPubMediationErrorDomain = @"com.applovin.sdk.mediation.mopub.errorDomain";

#pragma mark - MPBannerCustomEvent Overridden Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    [self log: @"Requesting AppLovin banner of size %@ with info: %@", NSStringFromCGSize(size), info];
    
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
        [self log: @"Failed to create an AppLovin Banner with invalid size"];
        
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
    [self log: @"Banner did load ad"];
    
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
    [self log: @"Banner failed to load with error: %d", code];
    
    NSError *error = [NSError errorWithDomain: kALMoPubMediationErrorDomain code: code userInfo: nil];
    [self.delegate bannerCustomEvent: self didFailToLoadAdWithError: error];
}

#pragma mark - Ad Display Delegate

- (void)ad:(ALAd *)ad wasDisplayedIn:(UIView *)view
{
    [self log: @"Banner displayed"];
    
    [self.delegate trackImpression];
    [self.delegate bannerCustomEventWillBeginAction: self];
}

- (void)ad:(ALAd *)ad wasHiddenIn:(UIView *)view
{
    [self log: @"Banner dismissed"];
    
    [self.delegate bannerCustomEventDidFinishAction: self];
}

- (void)ad:(ALAd *)ad wasClickedIn:(UIView *)view
{
    [self log: @"Banner clicked"];
    
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

- (void)log:(NSString *)format, ...
{
    if ( kALLoggingEnabled )
    {
        va_list valist;
        va_start(valist, format);
        NSString *message = [[NSString alloc] initWithFormat: format arguments: valist];
        va_end(valist);
        
        NSLog(@"AppLovinBannerCustomEvent: %@", message);
    }
}

@end
