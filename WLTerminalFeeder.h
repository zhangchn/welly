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

@interface WLTerminalFeeder : NSObject {
    int _savedCursorX;
    int _savedCursorY;
			
    enum { TP_NORMAL, TP_ESCAPE, TP_CONTROL, TP_SCS } _state;
	
    WLIntegerArray *_csBuf;
    WLIntegerArray *_csArg;
    unsigned int _csTemp;
	
    int _scrollBeginRow;
    int _scrollEndRow;
	
//	WLTerminal *_terminal;
	WLConnection *_connection;
	
	BOOL _hasNewMessage;	// to determine if a growl notification is needed
	
    enum { VT100, VT102 } _emustd;
	
    BOOL _modeScreenReverse;  // reverse (true), not reverse (false, default)
	BOOL _modeOriginRelative; // relative origin (true), absolute origin (false, default)
    BOOL _modeWraptext;       // autowrap (true, default), wrap disabled (false)
    BOOL _modeLNM;            // line feed (true, default), new line (false)
    BOOL _modeIRM;            // insert (true), replace (false, default)
}
@property (readonly) int cursorX;
@property (readonly) int cursorY;
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

- (cell *)cellsOfRow:(int)r NS_RETURNS_INNER_POINTER;
@end
