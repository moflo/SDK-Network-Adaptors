//
// AppLovin <--> MoPub Network Adaptors
//

#import "MPRewardedVideoCustomEvent.h"

#import <AppLovinSDK/AppLovinSDK.h>

// Use the below import statements if not integrating our SDK as a first-class framework
//#import "ALAdLoadDelegate.h"
//#import "ALAdDisplayDelegate.h"
//#import "ALAdRewardDelegate.h"
//#import "ALAdVideoPlaybackDelegate.h"

@interface AppLovinRewardedCustomEvent : MPRewardedVideoCustomEvent <ALAdLoadDelegate, ALAdDisplayDelegate, ALAdRewardDelegate, ALAdVideoPlaybackDelegate>

@end
