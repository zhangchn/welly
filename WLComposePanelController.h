//
//  TYComposeDelegate.h
//  Welly
//
//  Created by aqua9 on 17/1/2009.
//  Copyright 2009 TANG Yang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WLTerminalView;
@interface WLComposePanelController : NSObject {
	

}

+ (WLComposePanelController *)sharedInstance;

/* compose actions */
- (void)openComposePanelInWindow:(NSWindow *)window 
						 forView:(NSView <NSTextInput> *)telnetView;
- (IBAction)commitCompose:(id)sender;
- (IBAction)cancelCompose:(id)sender;
- (IBAction)setUnderline:(id)sender;
- (IBAction)setBlink:(id)sender;
- (IBAction)changeBackgroundColor:(id)sender;
- (void)clearAll;
@end
