//
// AppLovin <--> MoPub Network Adaptors
//

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALInterstitialAd.h"
    #import "ALAdService.h"
#endif

#import "MPInterstitialCustomEvent.h"

@interface AppLovinInterstitialCustomEvent : MPInterstitialCustomEvent <ALAdLoadDelegate, ALAdDisplayDelegate>

@property (strong, nonatomic) ALInterstitialAd* interstitialAd;
@property (strong, nonatomic) ALAd* loadedAd;

@end
