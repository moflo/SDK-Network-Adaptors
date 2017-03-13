//
// AppLovin <--> MoPub Network Adaptors
//

#if __has_include(<AppLovinSDK/AppLovinSDK.h>)
    #import <AppLovinSDK/AppLovinSDK.h>
#else
    #import "ALNativeAd.h"
    #import "ALNativeAdService.h"
    #import "ALPostbackDelegate.h"
#endif

#import "MPNativeAdAdapter.h"
#import "MPNativeAdConstants.h"

@interface AppLovinNativeAdapter : NSObject <MPNativeAdAdapter, ALPostbackDelegate>

@property (strong,   nonatomic) ALNativeAd* nativeAd;
@property (nonatomic, readonly) NSURL *defaultActionURL;
@property (nonatomic, readwrite) NSDictionary *properties;

- (id)initWithALNativeAd:(ALNativeAd *)ad;

@end
