//
//  ALAdWhirlLoadDelegate.h
//  AppLovin iOS AdWhirl Integration
//
//  Created by David Anderson on 12/3/12.
//  Copyright (c) 2012 AppLovin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALAdLoadDelegate.h"
#import "AdWhirlView.h"

@interface ALAdWhirlLoadDelegate : NSObject <ALAdLoadDelegate>

@property (nonatomic, retain) AdWhirlView *adWhirlView;

+(ALAdWhirlLoadDelegate *) initWithAdWhirlView: (AdWhirlView *) adWhirlView;

@end
