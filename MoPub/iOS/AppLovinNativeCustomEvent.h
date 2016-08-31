//
// AppLovin <--> MoPub Network Adaptors
//

#import "MPInterstitialCustomEvent.h"

#import "MPNativeCustomEvent.h"
#import "ALNativeAdLoadDelegate.h"
#import "ALNativeAdPrecacheDelegate.h"
#import "AppLovinNativeAdapter.h"
#import "MPNativeAd.h"

@interface AppLovinNativeCustomEvent : MPNativeCustomEvent <ALNativeAdLoadDelegate>

@property (strong, nonatomic) ALNativeAd* lastAd;
@property (strong, nonatomic) AppLovinNativeAdapter* nativeAdapter;
+ (void)ALLog:(NSString *)logMessage;
@end
