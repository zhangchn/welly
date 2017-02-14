//
//  WLTerminalFeeder.h
//  Welly
//
//  Created by K.O.ed on 08-8-11.
//  Copyright 2008 Welly Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommonType.h"

@class WLConnection, WLIntegerArray, WLTerminal;

@interface WLTerminalFeeder : NSObject
@property (readonly) NSInteger cursorX;
@property (readonly) NSInteger cursorY;
@property cell **grid;
@property (weak) WLTerminal *terminal;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithConnection:(WLConnection *)connection;
- (void)dealloc;

/* Input Interface */
- (void)feedData:(NSData *)data connection:(id)connection;
- (void)feedBytes:(const unsigned char*)bytes 
		   length:(NSUInteger)len 
	   connection:(id)connection;

//- (void)setTerminal:(WLTerminal *)terminal;

/* Clear */
- (void)clearAll;

- (cell *)cellsOfRow:(NSInteger)r NS_RETURNS_INNER_POINTER;
@end
