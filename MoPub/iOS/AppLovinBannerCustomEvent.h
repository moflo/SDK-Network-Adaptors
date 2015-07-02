//
// AppLovin <--> MoPub Network Adaptors
//

#import "MPBannerCustomEvent.h"
#import "ALAdView.h"

@interface AppLovinBannerCustomEvent : MPBannerCustomEvent <ALAdLoadDelegate>

@property (strong, nonatomic) ALAdView* bannerView;

@end
