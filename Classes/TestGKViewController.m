//
//  TestGKViewController.m
//  TestGK
//
//  Created by 上田 澄博 on 09/07/18.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TestGKViewController.h"

@implementation TestGKViewController

@synthesize gamePeerID;
@synthesize gameSession;

@synthesize mainTextView;
@synthesize chatTextField;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.mainTextView.text = @"";
	[self startPicker];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark -
#pragma mark Action Methods
- (void)startPicker {
	GKPeerPickerController* picker;
	picker = [[GKPeerPickerController alloc] init];
	picker.delegate = self;
	[picker show];
}

- (IBAction)sendChatMessage:(id)sender {
	NSString *message = self.chatTextField.text;
	if(![message isEqualToString:@""]) {
		NSMutableString *newText = [NSMutableString stringWithFormat:@"あなた: %@\n",message];
		[newText appendString:self.mainTextView.text];
		self.mainTextView.text = newText;
		[self sendData:[message dataUsingEncoding:NSUTF8StringEncoding]];
		self.chatTextField.text = @"";
	}
}

- (void)sendData:(NSData*)data {
	[self.gameSession sendData:data
					   toPeers:[NSArray arrayWithObject:self.gamePeerID]
			      withDataMode:GKSendDataReliable
						 error:nil];
}

#pragma mark -
#pragma mark GKPeerPickerControllerDelegate Methods

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker
		   sessionForConnectionType:(GKPeerPickerConnectionType)type 
{
	GKSession *session = [[GKSession alloc] initWithSessionID:@"TESTGK"
												  displayName:nil
												  sessionMode:GKSessionModePeer];
	return [session autorelease];
}

- (void)peerPickerController:(GKPeerPickerController *)picker
			  didConnectPeer:(NSString *)peerID
				   toSession:(GKSession *)session 
{
	self.gamePeerID = peerID;
	
	self.gameSession = session;
	self.gameSession.delegate = self;
	[self.gameSession setDataReceiveHandler:self withContext:nil];
	
	[picker dismiss];
	picker.delegate = nil;
}

- (void) receiveData:(NSData *)data
			fromPeer:(NSString *)peer
		   inSession: (GKSession *)session
			 context:(void *)context 
{
	NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSMutableString *newText = [NSMutableString stringWithFormat:@"あの人: %@\n",message];
	[newText appendString:self.mainTextView.text];
	self.mainTextView.text = newText;
}

@end
