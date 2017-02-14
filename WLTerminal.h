//
//  WLTerminal.h
//  Welly
//
//  YLTerminal.h
//  MacBlueTelnet
//
//  Created by Yung-Luen Lan on 2006/9/10.
//  Copyright 2006 yllan.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CommonType.h"

@class WLConnection, WLMessageDelegate, WLIntegerArray;
@class WLTerminal;

@protocol WLTerminalObserver

- (void)terminalDidUpdate:(WLTerminal *)terminal;

@end

@interface WLTerminal : NSObject {
    //unsigned int _offset;
	
    // cell **_grid;
    //BOOL **_dirty;
	// unichar *_textBuf;
}
@property NSInteger maxRow;
@property NSInteger maxColumn;
@property NSInteger cursorColumn;
@property NSInteger cursorRow;
@property cell **grid;
@property (weak, nonatomic) WLConnection *connection;
@property (assign, readwrite) WLBBSType bbsType;
@property (readonly) BBSState bbsState;

/* Clear */
- (void)clearAll;

/* Dirty */
- (BOOL)isDirtyAtRow:(NSInteger)r
			  column:(NSInteger)c;
- (void)setAllDirty;
- (void)setDirty:(BOOL)d 
		   atRow:(NSInteger)r
		  column:(NSInteger)c;
- (void)setDirtyForRow:(NSInteger)r;
- (void)removeAllDirtyMarks;

/* Access Data */
- (attribute)attrAtRow:(NSInteger)r
				column:(NSInteger)c ;
- (NSString *)stringAtIndex:(NSInteger)begin
					 length:(NSInteger)length;
- (NSAttributedString *)attributedStringAtIndex:(NSUInteger)location 
										 length:(NSUInteger)length;
- (cell *)cellsOfRow:(NSInteger)r NS_RETURNS_INNER_POINTER;
- (cell)cellAtIndex:(NSInteger)index;

/* Update State */
- (void)updateDoubleByteStateForRow:(NSInteger)r;
- (void)updateBBSState;

/* Accessor */
@property (NS_NONATOMIC_IOSONLY) WLEncoding encoding;

/* Input Interface */
- (void)feedGrid:(cell **)grid;
- (void)setCursorX:(NSInteger)cursorX
				 Y:(NSInteger)cursorY;

/* Observer Interface */
- (void)addObserver:(id <WLTerminalObserver>)observer;
@end
