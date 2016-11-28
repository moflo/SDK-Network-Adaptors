//
// AppLovin <--> MoPub Network Adaptors
//

#import "MPInterstitialCustomEvent.h"
#import <AppLovinSDK/AppLovinSDK.h>

// Use the below import statements if not integrating our SDK as a first-class framework
//#import "ALInterstitialAd.h"
//#import "ALAdService.h"

@interface AppLovinInterstitialCustomEvent : MPInterstitialCustomEvent <ALAdLoadDelegate, ALAdDisplayDelegate>

@property (strong, nonatomic) ALInterstitialAd* interstitialAd;
@property (strong, nonatomic) ALAd* loadedAd;

@end
