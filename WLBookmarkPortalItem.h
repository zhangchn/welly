//
//  WLPortalImage.h
//  Welly
//
//  Created by boost on 9/6/2009.
//  Copyright 2009 Xi Wang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WLPortalItem.h"
#import "WLSite.h"

@interface WLBookmarkPortalItem : WLPortalItem <WLPasteboardReceiver, WLDraggingSource>
@property (readwrite, copy, nonatomic) NSString *path;
@property (readwrite, strong, nonatomic) WLSite *site;
- (instancetype)initWithSite:(WLSite *)site;
- (instancetype)initWithPath:(NSString *)path title:(NSString *)title NS_DESIGNATED_INITIALIZER;
//- (void)setPath:(NSString *)path;


@end
