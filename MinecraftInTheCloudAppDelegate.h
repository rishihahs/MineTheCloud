//
//  MinecraftInTheCloudAppDelegate.h
//  MinecraftInTheCloud
//
//  Created by Rishi Shah on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MCCloud.h"

@interface MinecraftInTheCloudAppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (retain) IBOutlet NSButton* checkBox;

@property (assign) int world;
@property (retain) MCCloud* cl;

- (IBAction) worldChanged: (id)sender;
- (IBAction) cloudChanged: (id)sender;
- (IBAction) mineClicked: (id)sender;

@end
