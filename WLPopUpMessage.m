//
//  LLPopUpMessage.m
//  Welly
//
//  Created by gtCarrera @ 9# on 08-9-11.
//  Copyright 2008. All rights reserved.
//

#import "WLPopUpMessage.h"
#import "WLEffectView.h"

@interface WLPopUpMessage ()
@property WLEffectView *effectView;
@property (weak) NSTimer *prevTimer;

@end

@implementation WLPopUpMessage


#pragma mark Class methods

+ (instancetype)sharedInstance {
    static WLPopUpMessage *inst = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        inst = [WLPopUpMessage new];
    });
    return inst;
}

- (void)hidePopUpMessage {
	if (_effectView) {
		[_effectView removePopUpMessage];
		//[_effectView release];
        self.effectView = nil;
	}
    _prevTimer = nil;
}

- (void)showPopUpMessage:(NSString*)message
				duration:(CGFloat)duration 
			  effectView:(WLEffectView *)effectView {
    if (_prevTimer) {
        [_prevTimer invalidate];
    }
	[effectView drawPopUpMessage:message];
	_effectView = effectView;
	_prevTimer = [NSTimer scheduledTimerWithTimeInterval:duration
                                                  target:self 
                                                selector:@selector(hidePopUpMessage)
                                                userInfo:nil
                                                 repeats:NO];
}

+ (void)showPopUpMessage:(NSString*)message
                duration:(CGFloat)duration
              effectView:(WLEffectView *)effectView {
    [[WLPopUpMessage sharedInstance] showPopUpMessage:message duration:duration effectView:effectView];
}

+ (void)hidePopUpMessage {
    [[WLPopUpMessage sharedInstance] hidePopUpMessage];
}
@end
