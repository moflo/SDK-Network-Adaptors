//
//  BurstlyAppLovinAdaptor.m
//  BurstlySampleCL
//
//  Created by Matt Szaro on 5/28/13.
//
//

#import "BurstlyApplovinAdaptor.h"

@implementation BurstlyApplovinAdaptor
@synthesize sdk = _sdk;

- (id)initAdNetworkWithParams: (NSDictionary*)params
{
    NSString* key = [params objectForKey:@"AppLovinSdkKey"];
    
    if([key isEqualToString:@"publisher_sdk_key"])
        key = @"FwRy8vJWNE-GNd-zcPGIAGddcQUvm-c0v2z2xGTJVXat9Trmy536Mhlz6DttCTu5Wr7S6gmbCLTLuI6rOAylsg";
    
    return [self initWithAppLovinSdkKey: key];
}

-(id) initWithAppLovinSdkKey:(NSString *)sdkKey
{
    self = [super init];
    if(self)
    {
        ALSdkSettings* settings = [[ALSdkSettings alloc] init];
        [settings setIsVerboseLogging: YES];
        
        _sdk = [ALSdk sharedWithKey:sdkKey settings:settings];
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
/*    if ([[params objectForKey: @"size"] isEqual:@"BANNER"]) {
        return BurstlyAdPlacementTypeBanner;
    }
    else
    {
        return BurstlyAdPlacementTypeInterstitial;
    }
 */
    
    // debug
    return BurstlyAdPlacementTypeBanner;
}

- (id<BurstlyAdBannerProtocol>)newBannerAdWithParams: (NSDictionary *)params andError: (NSError **)error
{
    NSLog(@">>>>>>>>>>>>>> Asked for Banner adaptor");
    return [[BurstlyApplovinBannerAdaptor alloc] initWithSdk: _sdk];
}

- (id<BurstlyAdInterstitialProtocol>)newInterstitialAdWithParams: (NSDictionary *)params andError: (NSError **)error
{
    return [[BurstlyApplovinInterstitialAdaptor alloc] initWithSdk: _sdk];
}
@end
