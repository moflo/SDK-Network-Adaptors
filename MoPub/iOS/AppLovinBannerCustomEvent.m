//
// AppLovin <--> MoPub Network Adaptors
//

#if !__has_feature(objc_arc)
    #error This file must be compiled with ARC. Use the -fobjc-arc flag in the XCode build phases tab.
#endif

#import "AppLovinBannerCustomEvent.h"
#import "ALAdSize.h"
#import "MPConstants.h"

@implementation AppLovinBannerCustomEvent

static NSString* const kALMoPubMediationErrorDomain = @"com.applovin.sdk.mediation.mopub.errorDomain";

#pragma mark - MPBannerCustomEvent Subclass Methods

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info
{
    if (CGSizeEqualToSize(size, MOPUB_BANNER_SIZE)) {
        self.bannerView = [[ALAdView alloc] initWithSize: [ALAdSize sizeBanner]];
        self.bannerView.adLoadDelegate = self;
        
        [self.bannerView loadNextAd];
    }
    else
    {
        NSError* error = [NSError errorWithDomain: kALMoPubMediationErrorDomain
                                             code: -1
                                         userInfo: @{
                                                     NSLocalizedFailureReasonErrorKey : @"An invalid size was requested of this adapter."
                                                     }
                          ];
        
        [self.delegate bannerCustomEvent: self didFailToLoadAdWithError: error];
    }
}

- (void)dealloc
{
    self.bannerView.adLoadDelegate = nil;
}

#pragma mark - ALAdLoadDelegate methods

-(void)adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [self.delegate bannerCustomEvent:self didLoadAd: self.bannerView];

}

-(void)adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    NSError* error = [NSError errorWithDomain: kALMoPubMediationErrorDomain
                                         code: code
                                     userInfo: nil];
    
    [self.delegate bannerCustomEvent: self didFailToLoadAdWithError: error];
}

@end
