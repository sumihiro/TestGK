//
//  TestGKViewController.h
//  TestGK
//
//  Created by 上田 澄博 on 09/07/18.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface TestGKViewController : UIViewController <GKPeerPickerControllerDelegate,GKSessionDelegate> {
	NSString *gamePeerID;
	GKSession *gameSession;
	
	IBOutlet UITextView *mainTextView;
	IBOutlet UITextField *chatTextField;
}

@property (copy) NSString *gamePeerID;
@property (assign) GKSession *gameSession;

@property (retain) UITextView *mainTextView;
@property (retain) UITextField *chatTextField;

- (void)startPicker;
- (IBAction)sendChatMessage:(id)sender;
- (void)sendData:(NSData*)data;


@end

