Rewarded Videos
====================
For rewarded videos integration, add the files GADMAdapterAppLovinRewardBasedVideoAd.h and GADMAdapterAppLovinRewardBasedVideoAd.m into your Xcode project. In the AdMob dashboard, add AppLovin as an ad network.

Note: For some versions of AdMob iOS SDK, you would also need to add the header files from the "Mediation Adapters", coming with the SDK, into your Xcode project.

Interstitials
====================
For Interstitials integration, add the files AppLovinCustomEventInter.h and AppLovinCustomEventInter.m into your Xcode project. In the AdMob dashboard, create a custom event with the class nane: AppLovinCustomEventInter, as described [here](https://applovin.com/integration#adMobIntegration).

Unity Integration
====================
Our Unity adapter does not include our sdk as framework but as a library with header files. Therefore, you would need to edit the import statements of the adapters:

1.Comment out the framework import statement, i.e.:

Replace:

\#import \<AppLovinSDK/AppLovinSDK.h>

With:

//\#import \<AppLovinSDK/AppLovinSDK.h>


2.Uncomment all commented direct header import statements, for example:

Replace:

//\#import "ALInterstitialAd.h"

With:

import "ALInterstitialAd.h"
