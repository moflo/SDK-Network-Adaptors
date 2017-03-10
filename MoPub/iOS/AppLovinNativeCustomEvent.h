//
// AppLovin <--> MoPub Network Adaptors
//

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALNativeAdLoadDelegate.h"
    #import "ALNativeAdPrecacheDelegate.h"
    #import "ALSdk.h"
#endif

#import "MPInterstitialCustomEvent.h"
#import "MPNativeCustomEvent.h"
#import "MPNativeAd.h"
#import "AppLovinNativeAdapter.h"

@interface AppLovinNativeCustomEvent : MPNativeCustomEvent <ALNativeAdLoadDelegate>

@property (strong, nonatomic) ALNativeAd* lastAd;
@property (strong, nonatomic) AppLovinNativeAdapter* nativeAdapter;

+ (void)ALLog:(NSString *)logMessage;

@end
