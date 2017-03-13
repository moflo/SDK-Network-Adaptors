//
// AppLovin <--> MoPub Network Adaptors
//

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALAdLoadDelegate.h"
    #import "ALAdDisplayDelegate.h"
    #import "ALAdRewardDelegate.h"
    #import "ALAdVideoPlaybackDelegate.h"
    #import "ALIncentivizedInterstitialAd.h"
#endif

#import "MPRewardedVideoCustomEvent.h"

@interface AppLovinRewardedCustomEvent : MPRewardedVideoCustomEvent <ALAdLoadDelegate, ALAdDisplayDelegate, ALAdRewardDelegate, ALAdVideoPlaybackDelegate>

@end
