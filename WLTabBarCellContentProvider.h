//
//  WLTabBarContentProvider.h
//  Welly
//
//  Created by K.O.ed on 10-4-30.
//  Copyright 2010 Welly Group. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@protocol WLTabBarCellContentProvider

// PSMTabBarControl needs these methods being implemented to provider indicator/icon/count feature
@property (NS_NONATOMIC_IOSONLY, getter=isProcessing, readonly) BOOL processing;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSImage *icon;
@property (NS_NONATOMIC_IOSONLY, readonly) NSInteger objectCount;

@end
