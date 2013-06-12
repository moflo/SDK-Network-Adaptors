//
//  ALAdWhirlLoadDelegate.m
//  AppLovin iOS AdWhirl Integration
//
//  Created by David Anderson on 12/3/12.
//  Copyright (c) 2012 AppLovin. All rights reserved.
//

#import "ALAdWhirlLoadDelegate.h"

@implementation ALAdWhirlLoadDelegate

@synthesize adWhirlView;

+ (ALAdWhirlLoadDelegate *) initWithAdWhirlView:(AdWhirlView *)adWhirlView
{
    ALAdWhirlLoadDelegate *delegate = [[ALAdWhirlLoadDelegate alloc] init];
    delegate.adWhirlView = adWhirlView;
    
    return delegate;
}

- (void) adService:(ALAdService *)adService didLoadAd:(ALAd *)ad
{
    [[adWhirlView delegate] adWhirlDidReceiveAd:adWhirlView];
}

- (void) adService:(ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    [[adWhirlView delegate] adWhirlDidFailToReceiveAd:adWhirlView usingBackup:NO];
}

@end