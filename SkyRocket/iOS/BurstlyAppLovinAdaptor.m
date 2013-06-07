//
//  BurstlyAppLovinAdaptor.m
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import "BurstlyApplovinAdaptor.h"

@implementation BurstlyApplovinAdaptor
@synthesize sdk;

- (id)initAdNetworkWithParams: (NSDictionary*)params
{
    NSString* key = [params objectForKey:@"AppLovinSdkKey"];
    return [self initWithAppLovinSdkKey: key];
}

-(id) initWithAppLovinSdkKey:(NSString *)sdkKey
{
    self = [super init];
    if(self)
    {
        ALSdkSettings* settings = [[ALSdkSettings alloc] init];
        [settings setIsVerboseLogging: YES];
        
        self.sdk = [ALSdk sharedWithKey:sdkKey settings:settings];
    }
    return self;
}

- (NSString *)adaptorVersion {
    return @"1.0.0";
}

- (NSString *)version {
    return [ALSdk version];
}

- (BOOL)isIdiomSupported: (UIUserInterfaceIdiom)idiom {
    // We support both iPhone/iPod Touch and iPad.
    return YES;
}

- (BurstlyAdPlacementType) adPlacementTypeFor: (NSDictionary *)params {
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
    return [[BurstlyApplovinBannerAdaptor alloc] initWithSdk: sdk];
}

- (id<BurstlyAdInterstitialProtocol>)newInterstitialAdWithParams: (NSDictionary *)params andError: (NSError **)error
{
    return [[BurstlyApplovinInterstitialAdaptor alloc] initWithSdk: sdk];
}
@end
