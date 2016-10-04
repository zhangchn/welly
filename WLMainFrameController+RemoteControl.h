//
//  WLMainFrameController+RemoteControl.h
//  Welly
//
//  Created by K.O.ed on 10-4-30.
//  Copyright 2010 Welly Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WLMainFrameController.h"

@interface WLMainFrameController (RemoteControl)
- (void)initializeRemoteControl;

// for bindings access
@property (NS_NONATOMIC_IOSONLY, readonly, strong) RemoteControl *remoteControl;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) MultiClickRemoteBehavior *remoteBehavior;


// for timer
- (void)doScrollUp:(NSTimer*)timer;
- (void)doScrollDown:(NSTimer*)timer;
- (void)disableTimer;

@end
