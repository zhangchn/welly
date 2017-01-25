//
//  WLEffectView.m
//  Welly
//
//  Created by K.O.ed on 08-8-15.
//  Copyright 2008 Welly Group. All rights reserved.
//

#import "WLEffectView.h"
#import "WLTerminalView.h"
#import "WLGlobalConfig.h"

#import <Quartz/Quartz.h>
#import <ScreenSaver/ScreenSaver.h>
#import <CoreText/CTFont.h>

#define OMIT_IMPLIED_ANIM_BEGIN \
	[CATransaction begin]; \
	[CATransaction setValue:[NSNumber numberWithFloat:0.0f] \
					 forKey:kCATransactionAnimationDuration]

#define OMIT_IMPLIED_ANIM_END \
	[CATransaction commit]

@implementation WLEffectView
- (instancetype)initWithView:(WLTerminalView *)view {
	self = [self initWithFrame:view.frame];
	if (self) {
		_mainView = view;
		[self setWantsLayer:YES];
	}
	return self;
}

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		self.frame = frame;
		[self setWantsLayer:YES];
    }
    return self;
}

- (void)dealloc {
	//[_mainLayer release];
	//[_ipAddrLayer release];
	if (_buttonLayer) {
		[_buttonLayer.sublayers.lastObject removeFromSuperlayer];
	}
	
	CGColorRelease(_popUpLayerTextColor);
    CGFontRelease(_popUpLayerTextFont);
}

- (void)setupLayer {
	NSRect contentFrame = _mainView.frame;
	self.frame = contentFrame;
	
    // mainLayer is the layer that gets scaled. All of its sublayers
    // are automatically scaled with it.
	if (!_mainLayer) {
		_mainLayer = [CALayer layer];
		
		// Make the background color to be a dark gray with a 50% alpha similar to
		// the real Dashbaord.
		CGColorRef bgColor = CGColorCreateGenericRGB(0.0, 0.0, 0.0, 0.0);
		_mainLayer.backgroundColor = bgColor;
		CGColorRelease(bgColor);
		
		self.layer = _mainLayer;
	}
    _mainLayer.frame = NSRectToCGRect(contentFrame);
}

- (void)clear {
	[self clearIPAddrBox];
	[self clearClickEntry];
	[self clearButton];
}

- (void)drawRect:(NSRect)rect {
	// Drawing code here.
}

- (void)resize {
	[self setFrameSize:_mainView.frame.size];
	[self setFrameOrigin:NSMakePoint(0, 0)];
}

- (void)awakeFromNib {
	[self setupLayer];
}

- (void)setIPAddrBox {
	_ipAddrLayer = [CALayer layer];
    
	// Set up the box
	CGColorRef ipAddrLayerBGColor = CGColorCreateGenericRGB(0.0, 0.95, 0.95, 0.1f);
	CGColorRef ipAddrLayerBorderColor = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0f);
	_ipAddrLayer.backgroundColor = ipAddrLayerBGColor;
	_ipAddrLayer.borderColor = ipAddrLayerBorderColor;
	CGColorRelease(ipAddrLayerBGColor);
	CGColorRelease(ipAddrLayerBorderColor);
	_ipAddrLayer.borderWidth = 1.4;
	_ipAddrLayer.cornerRadius = 6.0;
	
    // Insert the layer into the root layer
	[_mainLayer addSublayer:_ipAddrLayer];
}

- (void)drawIPAddrBox:(NSRect)rect {
	if (!_ipAddrLayer)
		[self setIPAddrBox];
	
	rect.origin.x -= 1.0;
	rect.origin.y -= 0.0;
	rect.size.width += 2.0;
	rect.size.height += 0.0;
	
    // Set the layer frame to the rect
    _ipAddrLayer.frame = NSRectToCGRect(rect);
    
    // Set the opacity to make the layer appear
	_ipAddrLayer.opacity = 1.0f;
}

- (void)clearIPAddrBox {
	_ipAddrLayer.opacity = 0.0f;
}

#pragma mark Click Entry
- (void)setupClickEntry {
	_clickEntryLayer = [CALayer layer];
    
	CGColorRef clickEntryLayerBGColor = CGColorCreateGenericRGB(0.0, 0.95, 0.95, 0.17f);
	_clickEntryLayer.backgroundColor = clickEntryLayerBGColor;
	CGColorRelease(clickEntryLayerBGColor);
	_clickEntryLayer.borderWidth = 0;
	_clickEntryLayer.cornerRadius = 6.0;
	
    // Insert the layer into the root layer
	[_mainLayer addSublayer:_clickEntryLayer];
}

- (void)drawClickEntry:(NSRect)rect {
	if (!_clickEntryLayer)
		[self setupClickEntry];
	
	rect.origin.x -= 1.0;
	rect.origin.y -= 0.0;
	rect.size.width += 2.0;
	rect.size.height += 0.0;
	
    // Set the layer frame to the rect
    _clickEntryLayer.frame = NSRectToCGRect(rect);
    
    // Set the opacity to make the layer appear
	_clickEntryLayer.opacity = 1.0f;
}

- (void)clearClickEntry {
	_clickEntryLayer.opacity = 0.0f;
}

#pragma mark Welly Buttons
- (void)setupButtonLayer {
	_buttonLayer = [CALayer layer];
	// Set the colors of the pop-up layer
	CGColorRef myColor = CGColorCreateGenericRGB(0.05, 0.05, 0.05, 0.9f);
	_buttonLayer.backgroundColor = myColor;
	CGColorRelease(myColor);
	myColor = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.9f);
	_buttonLayer.borderColor = myColor;
	CGColorRelease(myColor);
	_buttonLayer.borderWidth = 2.0;
	_buttonLayer.cornerRadius = 10.0;
	
    // Create a text layer to add so we can see the messages.
    CATextLayer *textLayer = [CATextLayer layer];
	//[textLayer autorelease];
	// Set its foreground color
	myColor = CGColorCreateGenericRGB(1, 1, 1, 1.0f);
    textLayer.foregroundColor = myColor;
	CGColorRelease(myColor);
	
	[_buttonLayer addSublayer:textLayer];
	
	CATransition *buttonTrans = [CATransition new];
	buttonTrans.type = kCATransitionFade;
	[_buttonLayer addAnimation:buttonTrans forKey:kCATransition];
    //[buttonTrans autorelease];
	[_buttonLayer setHidden:YES];
    // Insert the layer into the root layer
	[_mainLayer addSublayer:_buttonLayer];
}

- (void)drawButton:(NSRect)rect 
	   withMessage:(NSString *)message {
	//Initiallize a new CALayer
	[self clearButton];
	if (!_buttonLayer)
		[self setupButtonLayer];
	
	CATextLayer *textLayer = (CATextLayer *) _buttonLayer.sublayers.lastObject;
	
	// Set the message to the text layer
	textLayer.string = message;
	// Modify its styles
	textLayer.truncationMode = kCATruncationEnd;
    CGFontRef font = CGFontCreateWithFontName((CFStringRef)[WLGlobalConfig sharedInstance].englishFontName);
    textLayer.font = font;
	textLayer.fontSize = [WLGlobalConfig sharedInstance].englishFontSize - 2;
	// Here, calculate the size of the text layer
	NSDictionary *attributes = @{NSFontAttributeName: [NSFont fontWithName:[WLGlobalConfig sharedInstance].englishFontName 
												size:textLayer.fontSize]};
	NSSize messageSize = [message sizeWithAttributes:attributes];
	
	// Change the size of text layer automatically
	NSRect textRect = NSZeroRect;
	textRect.size.width = messageSize.width;
	textRect.size.height = messageSize.height;
    CGFontRelease(font);
	
    // Create a new rectangle with a suitable size for the inner texts.
	// Set it to an appropriate position of the whole view
	NSRect finalRect = rect;
	if (finalRect.size.width < textRect.size.width + 8)
		finalRect.size.width = textRect.size.width + 8;
	finalRect.size.height = textRect.size.height + 4;
	
	// Move the origin point of the message layer, so the message can be 
	// displayed in the center of the background rect
	textRect.origin.x += (finalRect.size.width - textRect.size.width) / 2.0;
	textRect.origin.y += (finalRect.size.height - textRect.size.height) / 2.0;
	
	// We don't want the implied animation for moving
	OMIT_IMPLIED_ANIM_BEGIN;
	
    // Set the layer frame to our rectangle.
	textLayer.frame = NSRectToCGRect(textRect);
    _buttonLayer.frame = NSRectToCGRect(finalRect);
	
	// Now commit the animation transaction, omit all animations
	OMIT_IMPLIED_ANIM_END;
	
	// Now we reveal the button layer at new position
	[_buttonLayer setHidden:NO];
}

- (void)clearButton {
	if (_buttonLayer == nil)
		return;
	
	[_buttonLayer setHidden:YES];
}

#pragma mark -
#pragma mark URL drawing
- (CGImageRef)indicatorImage { 
	if (_urlIndicatorImage == NULL) { 
		NSString *path = [[NSBundle mainBundle] pathForResource:@"indicator" 
														 ofType:@"png"]; 
		NSURL *imageURL = [NSURL fileURLWithPath:path]; 
		CGImageSourceRef src = CGImageSourceCreateWithURL((CFURLRef)imageURL, NULL); 
		if (NULL != src) { 
			_urlIndicatorImage = CGImageSourceCreateImageAtIndex(src, 0, NULL); 
			CFRelease(src);
		} 
	} 
	return _urlIndicatorImage; 
} 

- (void)setupURLIndicatorLayer {
	_urlIndicatorLayer = [CALayer layer];
	_urlIndicatorLayer.contents = (id)[self indicatorImage];
	_urlIndicatorLayer.frame = CGRectMake(0, 0, 79, 90);
	[_mainLayer addSublayer:_urlIndicatorLayer];
}

- (void)showIndicatorAtPoint:(NSPoint)point {
	if (!_urlIndicatorLayer)
		[self setupURLIndicatorLayer];
	_urlIndicatorLayer.opacity = 0.9;
	CGRect rect = _urlIndicatorLayer.frame;
	rect.origin = NSPointToCGPoint(point);
	_urlIndicatorLayer.frame = rect;
}

- (void)removeIndicator {
	if (_urlIndicatorLayer)
		_urlIndicatorLayer.opacity = 0.0f;
}

#pragma mark Pop-Up Message
- (void)setupPopUpLayer {
    NSAssert(_popUpLayer == nil, @"Setup pop-up layer when there exists one already!");
    _popUpLayer = [CALayer layer];
	
	// Set the colors of the pop-up layer
	CGColorRef popUpLayerBGColor = CGColorCreateGenericRGB(0.1, 0.1, 0.1, 0.5f);
	CGColorRef popUpLayerBorderColor = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 0.75f);
	_popUpLayer.backgroundColor = popUpLayerBGColor;
	_popUpLayer.borderColor = popUpLayerBorderColor;
	CGColorRelease(popUpLayerBGColor);
	CGColorRelease(popUpLayerBorderColor);
	_popUpLayer.borderWidth = 2.0;
    
    // Move to proper position before shows up, avoiding moving on screen
    NSRect rect = self.frame;
	rect.origin.x = rect.size.width / 2;
	rect.origin.y = rect.size.height / 5;
    rect.size.width = 0;
    rect.size.height = 0;
	
    _popUpLayer.frame = NSRectToCGRect(rect);
    
	// Set up text color/font, which would be used many times
	_popUpLayerTextColor = CGColorCreateGenericRGB(1.0, 1.0, 1.0, 1.0f);
	_popUpLayerTextFont = CGFontCreateWithFontName((CFStringRef)DEFAULT_POPUP_BOX_FONT);
	
	// Create a text layer to add so we can see the message.
    CATextLayer *textLayer = [CATextLayer layer];
	//[textLayer autorelease];
	// Set its foreground color
    textLayer.foregroundColor = _popUpLayerTextColor;
	// Modify its styles
	textLayer.truncationMode = kCATruncationEnd;
    textLayer.font = _popUpLayerTextFont;

	[_popUpLayer addSublayer:textLayer];
	// Insert the layer into the root layer
	[_mainLayer addSublayer:_popUpLayer];
}

// Just similiar to the code of "addNewLayer"...
// by gtCarrera @ 9#
- (void)drawPopUpMessage:(NSString *)message {
	// Remove previous message
	[self removePopUpMessage];
	//Initiallize a new CALayer
	if (!_popUpLayer) {
		[self setupPopUpLayer];
    }	
	
	CATextLayer *textLayer = (CATextLayer *)_popUpLayer.sublayers.lastObject;
	
	// Set the message to the text layer
	textLayer.string = message;
	// Here, calculate the size of the text layer
	NSDictionary *attributes = @{NSFontAttributeName: [NSFont fontWithName:DEFAULT_POPUP_BOX_FONT 
												size:textLayer.fontSize]};
	NSSize messageSize = [message sizeWithAttributes:attributes];
	
	// Change the size of text layer automatically
	NSRect textRect = NSZeroRect;
	textRect.size.width = messageSize.width;
	textRect.size.height = messageSize.height;
	
    // Create a new rectangle with a suitable size for the inner texts.
	// Set it to an appropriate position of the whole view
    NSRect rect = textRect;
	NSRect screenRect = self.frame;
	rect.size.height += 10;
	rect.size.width += 50;
	rect.origin.x = screenRect.size.width / 2 - rect.size.width / 2;
	rect.origin.y = screenRect.size.height / 5;
	
	// Move the origin point of the message layer, so the message can be 
	// displayed in the center of the background layer
	textRect.origin.x += (rect.size.width - textRect.size.width) / 2.0;
	textLayer.frame = NSRectToCGRect(textRect);
	
    // Set the layer frame to our rectangle.
    _popUpLayer.frame = NSRectToCGRect(rect);
	_popUpLayer.cornerRadius = rect.size.height/5;
    
	[_popUpLayer setHidden:NO];
}

- (void)removePopUpMessage {
	if(_popUpLayer) {
		[_popUpLayer setHidden:YES];
	}
}

@end
