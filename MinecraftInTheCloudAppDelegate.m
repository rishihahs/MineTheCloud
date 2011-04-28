//
//  MinecraftInTheCloudAppDelegate.m
//  MinecraftInTheCloud
//
//  Created by Rishi Shah on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MinecraftInTheCloudAppDelegate.h"
#import "MCCloud.h"

@implementation MinecraftInTheCloudAppDelegate

@synthesize window;
@synthesize checkBox;

@synthesize world;
@synthesize cl;

- (id) init {
	
	if (self = [super init]) {
		self.world = 1;
		self.cl = [[[MCCloud alloc] init] autorelease];
	}
	
	return self;
}

- (void) dealloc {
	self.cl = nil;
	
	[super dealloc];
}

- (IBAction) worldChanged: (id)sender {
	if ([sender indexOfSelectedItem] > 4) {
		self.world = 1;
		return;
	}
	
	switch ([sender indexOfSelectedItem]) {
		case 0:
			self.world = 1;
			break;
		case 1:
			self.world = 2;
			break;
		case 2:
			self.world = 3;
			break;
		case 3:
			self.world = 4;
			break;
		case 4:
			self.world = 5;
			break;
		default:
			self.world = 1;
			break;
	}
}

- (IBAction) cloudChanged: (id)sender {
	NSOpenPanel* openPanel = [NSOpenPanel openPanel];
	[openPanel setAllowsMultipleSelection:NO];
	[openPanel setCanChooseFiles:NO];
	[openPanel setCanChooseDirectories:YES];
	
	int result = [openPanel runModalForDirectory:NSHomeDirectory() file:nil];
	
	if (result == NSOKButton) {
		self.cl.DROPBOX = [openPanel filename];
		[sender setTitle:self.cl.DROPBOX];
	}
	
}

- (IBAction) mineClicked: (id)sender {
	NSString* currentWorld;
	
	switch (self.world) {
		case 1:
			currentWorld = self.cl.WORLD1;
			break;
		case 2:
			currentWorld = self.cl.WORLD2;
			break;
		case 3:
			currentWorld = self.cl.WORLD3;
			break;
		case 4:
			currentWorld = self.cl.WORLD4;
			break;
		case 5:
			currentWorld = self.cl.WORLD5;
			break;
		default:
			currentWorld = self.cl.WORLD1;
			break;
	}
	
	NSError* error = nil;
	
	if ([checkBox state])
		error = [cl initializeCloudWithoutCopying:self.cl.DROPBOX worlds:currentWorld];
	
	else
		error = [cl initializeCloud:self.cl.DROPBOX worlds:currentWorld];
	
	if (error != nil) {
		[NSApp presentError:error];
	}
	
	else {
		[sender setTitle:@"Done!"];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
}

- (void)awakeFromNib {
	[window setDelegate:self];
}

- (void)windowWillClose:(NSNotification *)aNotification {
	[NSApp terminate:self];
}

@end
