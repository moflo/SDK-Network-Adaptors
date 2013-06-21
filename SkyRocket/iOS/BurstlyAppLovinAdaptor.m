//
//  BurstlyAppLovinAdaptor.m
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import "BurstlyApplovinAdaptor.h"

@implementation BurstlyApplovinAdaptor
@synthesize sdk, bannerRefreshRate;

- (id)initAdNetworkWithParams: (NSDictionary*)params
{
    self = [super init];
    if(self)
    {
        ALSdkSettings* settings = [[ALSdkSettings alloc] init];
        [settings setIsVerboseLogging: YES];
        
        NSString* appLovinSdkKey = [params objectForKey:@"AppLovinSdkKey"];
        self.sdk = [ALSdk sharedWithKey: appLovinSdkKey settings:settings];
        
        NSNumber* bannerRefresh = [params objectForKey:@"BannerRefreshRate"];
        if (bannerRefresh != nil)
        {
            // If you provide a custom refresh rate via Burstly, you must also do so in the AppLovin UI (under Manage Apps).
            self.bannerRefreshRate = bannerRefresh;
        }
        else
        {
            // AppLovin default refresh rate is 120 seconds.
            self.bannerRefreshRate = @120;
        }
    }
    return self;
}

- (BOOL)isIdiomSupported: (UIUserInterfaceIdiom)idiom
{
    // We support both iPhone/iPod Touch and iPad.
    return YES;
}

- (BurstlyAdPlacementType) adPlacementTypeFor: (NSDictionary *)params
{
  if ([[params objectForKey: @"size"] isEqual:@"BANNER"]) {
        return BurstlyAdPlacementTypeBanner;
    }
    else
    {
        return BurstlyAdPlacementTypeInterstitial;
    }
}

- (id<BurstlyAdBannerProtocol>)newBannerAdWithParams: (NSDictionary *)params andError: (NSError **)error
{
    return [[BurstlyApplovinBannerAdaptor alloc] initWithSdk: sdk bannerRefreshRate: bannerRefreshRate];
}

- (id<BurstlyAdInterstitialProtocol>)newInterstitialAdWithParams: (NSDictionary *)params andError: (NSError **)error
{
    return [[BurstlyApplovinInterstitialAdaptor alloc] initWithSdk: sdk];
}

- (NSString *)adaptorVersion
{
    return @"1.0.1";
}

- (NSString *) version
{
    return [ALSdk version];
}

- (NSString*) sdkVersion
{
    return [ALSdk version];
}

@end
