//
//  WLSiteDelegate.h
//  Welly
//
//  Created by K.O.ed on 09-9-29.
//  Copyright 2009 Welly Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define floatWindowLevel kCGStatusWindowLevel+1

@class WLSite;

@protocol WLSitesObserver

- (void)sitesDidChanged:(NSArray *)sitesAfterChange;

@end


@interface WLSitesPanelController : NSObject
@property (weak, readonly) NSArray *sites;

/* Accessors */
+ (WLSitesPanelController *)sharedInstance;
+ (void)addSitesObserver:(NSObject<WLSitesObserver> *)observer;
+ (NSArray *)sites;
+ (WLSite *)siteAtIndex:(NSUInteger)index;
@property (NS_NONATOMIC_IOSONLY, readonly) unsigned int countOfSites;

/* Site Panel Actions */
- (IBAction)connectSelectedSite:(id)sender;
- (IBAction)closeSitesPanel:(id)sender;

- (IBAction)proxyTypeDidChange:(id)sender;
- (void)openSitesPanelInWindow:(NSWindow *)mainWindow;
- (void)openSitesPanelInWindow:(NSWindow *)mainWindow 
				   andAddSite:(WLSite *)site;

/* password window actions */
- (IBAction)openPasswordDialog:(id)sender;
- (IBAction)confirmPassword:(id)sender;
- (IBAction)cancelPassword:(id)sender;

@end
