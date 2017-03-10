//
// AppLovin <--> MoPub Network Adaptors
//

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use the -fobjc-arc flag in the XCode build phases tab.
#endif

#import "AppLovinNativeCustomEvent.h"
#import "MPNativeCustomEventDelegate.h"
#import "MPNativeCustomEvent.h"
#import "MPNativeAdError.h"

@implementation AppLovinNativeCustomEvent

static NSString* const kALMoPubMediationErrorDomain = @"com.applovin.sdk.mediation.mopub.errorDomain";
static BOOL loggingEnabled = YES;

- (void)requestAdWithCustomEventInfo:(NSDictionary *)info {
    
    [AppLovinNativeCustomEvent ALLog:@"Requesting ad."];
    [[ALSdk shared] setPluginVersion:@"MoPubNative-1.0"];
    [[ALSdk shared].nativeAdService loadNativeAdGroupOfCount: 1 andNotify: self];

}

-(void) nativeAdService:(alnonnull ALNativeAdService *)service didLoadAds:(alnonnull NSArray *)ads
{
    
    [AppLovinNativeCustomEvent ALLog:@"Ad was successfully loaded from AppLovin."];
    
   ALNativeAd *nativeAd = ((ALNativeAd *)ads[0]);
    
    NSMutableArray *imageURLs = [NSMutableArray array];
    
    if (nativeAd.iconURL) {
        [imageURLs addObject:nativeAd.iconURL];
    }
    if (nativeAd.imageURL) {
        [imageURLs addObject:nativeAd.imageURL];
    }
    
    [super precacheImagesWithURLs:imageURLs completionBlock:^(NSArray *errors) {
        if (errors) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [AppLovinNativeCustomEvent ALLog:@"Failed to precache images."];
                
                NSError* error = [NSError errorWithDomain: kALMoPubMediationErrorDomain
                                                     code: MPNativeAdErrorImageDownloadFailed
                                                 userInfo: nil
                                  ];
                
                [self.delegate nativeCustomEvent:self didFailToLoadAdWithError: error];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [AppLovinNativeCustomEvent ALLog:@"Successfully precached images."];
                self.lastAd = nativeAd;
                self.nativeAdapter = [[AppLovinNativeAdapter alloc] initWithALNativeAd:ads[0]];
                MPNativeAd *nativeAd = [[MPNativeAd alloc] initWithAdAdapter:self.nativeAdapter];
                [self.delegate nativeCustomEvent:self didLoadAd:nativeAd];
            });

        }
    }];
    
}

-(void) nativeAdService:(alnonnull ALNativeAdService *)service didFailToLoadAdsWithError:(NSInteger)code
{
    dispatch_async(dispatch_get_main_queue(), ^{
    [AppLovinNativeCustomEvent ALLog:@"Ad failed to load."];


    NSError* error = [NSError errorWithDomain: kALMoPubMediationErrorDomain
                                         code: MPNativeAdErrorNoInventory
                                     userInfo: nil
                      ];
    
    [self.delegate nativeCustomEvent:self didFailToLoadAdWithError: error];
    });

}


+ (void)ALLog:(NSString *)logMessage {
    if (loggingEnabled) {
        NSLog(@"AppLovinAdapter: %@", logMessage);
    }
}


@end
