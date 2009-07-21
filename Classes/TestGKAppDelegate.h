//
//  TestGKAppDelegate.h
//  TestGK
//
//  Created by 上田 澄博 on 09/07/18.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestGKViewController;

@interface TestGKAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TestGKViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TestGKViewController *viewController;

@end

