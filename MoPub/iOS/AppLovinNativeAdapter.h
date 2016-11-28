//
// AppLovin <--> MoPub Network Adaptors
//

#import "MPNativeAdAdapter.h"
#import "MPNativeAdConstants.h"

#import <AppLovinSDK/AppLovinSDK.h>

// Use the below import statements if not integrating our SDK as a first-class framework
//#import "ALNativeAd.h"
//#import "ALNativeAdService.h"
//#import "ALPostbackDelegate.h"

@interface AppLovinNativeAdapter : NSObject <MPNativeAdAdapter, ALPostbackDelegate>

@property (strong,   nonatomic) ALNativeAd* nativeAd;
@property (nonatomic, readonly) NSURL *defaultActionURL;
@property (nonatomic, readwrite) NSDictionary *properties;

- (id)initWithALNativeAd:(ALNativeAd *)ad;

@end
