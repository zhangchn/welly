//
//  WLTermView.h
//  Welly
//
//  Created by K.O.ed on 09-11-2.
//  Copyright 2009 Welly Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WLTabView.h"

@class WLTerminal, WLConnection, WLAsciiArtRender;

@interface WLTermView : NSView <WLTabItemContentObserver>
@property CGFloat fontWidth;
@property CGFloat fontHeight;
@property int maxRow;
@property int maxColumn;

- (void)updateBackedImage;
- (void)configure;

@property (NS_NONATOMIC_IOSONLY, readonly, strong) WLTerminal *frontMostTerminal;
@property (NS_NONATOMIC_IOSONLY, readonly, strong) WLConnection *frontMostConnection;
@property (NS_NONATOMIC_IOSONLY, getter=isConnected, readonly) BOOL connected;

- (void)refreshDisplay;
- (void)terminalDidUpdate:(WLTerminal *)terminal;

// get current BBS image
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSImage *image;
@end
