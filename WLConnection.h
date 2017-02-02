//
//  WLConnection.h
//  Welly
//
//  YLConnection.h
//  MacBlueTelnet
//
//  Created by Lan Yung-Luen on 12/7/07.
//  Copyright 2007 yllan.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WLProtocol.h"
#import "WLTabBarCellContentProvider.h"

@class WLSite, WLTerminal, WLTerminalFeeder, WLMessageDelegate;

// modified by boost @ 9#
// inhert from NSObjectController for PSMTabBarControl
@interface WLConnection : NSObject <WLTabBarCellContentProvider>
@property (readwrite, strong) WLSite *site;
@property (readwrite, strong, nonatomic) WLTerminal *terminal;
@property (readwrite, strong) WLTerminalFeeder *terminalFeeder;
@property (readwrite, strong) NSObject <WLProtocol> *protocol;
@property (assign, nonatomic, getter=isConnected) BOOL connected;
@property (readonly) NSDate *lastTouchDate;
@property (readonly) NSInteger messageCount;
@property (readonly) WLMessageDelegate *messageDelegate;
// for PSMTabBarControl
@property (readwrite, copy) NSImage *icon;
@property (readwrite, assign, getter=isProcessing) BOOL processing;
@property (readwrite, assign) NSInteger objectCount;
@property (readwrite, weak) id tabViewItemController;

- (instancetype)initWithSite:(WLSite *)site;

- (void)close;
- (void)reconnect;
- (void)sendMessage:(NSData *)msg;
- (void)sendBytes:(const void *)buf 
		   length:(NSInteger)length;
- (void)sendText:(NSString *)text;
- (void)sendText:(NSString *)text 
	   withDelay:(int)microsecond;

/* message */
- (void)didReceiveNewMessage:(NSString *)message
				  fromCaller:(NSString *)caller;
- (void)increaseMessageCount:(NSInteger)value;
- (void)resetMessageCount;
@end
