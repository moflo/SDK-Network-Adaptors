//
// AppLovin <--> MoPub Network Adaptors
//

#import "MPNativeAdAdapter.h"
#import "ALNativeAd.h"
#import "ALNativeAdService.h"
#import "MPNativeAdConstants.h"
#import "ALPostbackDelegate.h"


@interface AppLovinNativeAdapter : NSObject <MPNativeAdAdapter, ALPostbackDelegate>


@property (strong, nonatomic) ALNativeAd* nativeAd;
@property (nonatomic, readonly) NSURL *defaultActionURL;
@property (nonatomic, readwrite) NSDictionary *properties;

- (id)initWithALNativeAd:(ALNativeAd *)ad;

@end
