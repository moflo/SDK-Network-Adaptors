//
//  ALDAdWhirlController.m
//  AppLovin-iPhone-SDK-DemoApp
//
//  Created by David Anderson on 12/3/12.
//  Copyright (c) 2012 AppLovin. All rights reserved.
//

#import "ALDAdWhirlController.h"


@implementation ALDAdWhirlController


-(NSString *)adWhirlApplicationKey
{
    return @"YOUR_API_KEY";
}

- (UIViewController *)viewControllerForPresentingModalView
{
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create new AdView
    AdWhirlView *adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
    [self.view addSubview:adWhirlView];
}

- (void)applovinAdWhirlEvent:(AdWhirlView *)adWhirlView
{
    ALAdView *alAdview = [[ALAdView alloc] initBannerAd];
    [alAdview setAdLoadDelegate: [ALAdWhirlLoadDelegate initWithAdWhirlView:adWhirlView] ];
    [alAdview loadNextAd];
    
    [adWhirlView replaceBannerViewWith:alAdview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
