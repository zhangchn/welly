//
//  WLAutoReplyDelegate.h
//  MacBlueTelnet
//
//  Created by K.O.ed on 08-3-28.
//  Copyright 2008 9# Dept. Water. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommonType.h"

@class WLConnection;
@interface WLMessageDelegate : NSObject
@property (readonly) int unreadCount;

- (instancetype)initWithConnection:(WLConnection *)connection;

- (void)setConnection:(WLConnection *)connection;
- (void)connectionDidReceiveNewMessage:(NSString *)message
							fromCaller:(NSString *)callerName;
- (void)showUnreadMessagesOnTextView:(NSTextView *)textView;
@end
