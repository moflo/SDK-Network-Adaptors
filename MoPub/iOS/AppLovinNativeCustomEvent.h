//
// AppLovin <--> MoPub Network Adaptors
//

#import "MPInterstitialCustomEvent.h"
#import "MPNativeCustomEvent.h"
#import "MPNativeAd.h"

#import <AppLovinSDK/AppLovinSDK.h>

// Use the below import statements if not integrating our SDK as a first-class framework
//#import "ALNativeAdLoadDelegate.h"
//#import "ALNativeAdPrecacheDelegate.h"

#import "AppLovinNativeAdapter.h"

@interface AppLovinNativeCustomEvent : MPNativeCustomEvent <ALNativeAdLoadDelegate>

@property (strong, nonatomic) ALNativeAd* lastAd;
@property (strong, nonatomic) AppLovinNativeAdapter* nativeAdapter;

+ (void)ALLog:(NSString *)logMessage;

@end
