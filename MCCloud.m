//
//  MCCloud.m
//  MinecraftInTheCloud
//
//  Created by Rishi Shah on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MCCloud.h"

@interface MCCloud ()
// MineCraft
@property (readwrite, copy) NSString* MINECRAFT;
@property (readwrite, copy) NSString* WORLD1;
@property (readwrite, copy) NSString* WORLD2;
@property (readwrite, copy) NSString* WORLD3;
@property (readwrite, copy) NSString* WORLD4;
@property (readwrite, copy) NSString* WORLD5;
@property (readwrite, copy) NSString* WORLDS;

// Private methods
- (NSError*) copyToCloud: (NSString *)cloud worlds:(NSString *)world;
- (NSError*) deleteToCloud: (NSString *)cloud worlds:(NSString *)world;
@end


@implementation MCCloud

// Clouds
@synthesize DROPBOX;

// MineCraft
@synthesize MINECRAFT;
@synthesize WORLD1;
@synthesize WORLD2;
@synthesize WORLD3;
@synthesize WORLD4;
@synthesize WORLD5;
@synthesize WORLDS;

- (id) init {

	if (self = [super init]) {
		// Clouds
		self.DROPBOX = [NSHomeDirectory() stringByAppendingPathComponent:@"Dropbox"];
		
		// MineCraft
		self.MINECRAFT = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/minecraft"];
		self.WORLD1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/minecraft/saves/World1"];
		self.WORLD2 = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/minecraft/saves/World2"];
		self.WORLD3 = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/minecraft/saves/World3"];
		self.WORLD4 = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/minecraft/saves/World4"];
		self.WORLD5 = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/minecraft/saves/World5"];
		self.WORLDS = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Application Support/minecraft/saves"];
	}

	return self;
}

- (void) dealloc {
	// Clouds
	self.DROPBOX = nil;
	
	// MineCraft
	self.MINECRAFT = nil;
	self.WORLD1 = nil;
	self.WORLD2 = nil;
	self.WORLD3 = nil;
	self.WORLD4 = nil;
	self.WORLD5 = nil;
	self.WORLDS = nil;
	
	[super dealloc];
}

- (void) createLink: (NSString*)destFolder inFolder:(NSString *)parentFolder {
	NSString *path = @"/bin/ln";
	NSArray *args = [NSArray arrayWithObjects:
					 @"-s", 
					 [destFolder retain],
					 [parentFolder retain],
					 nil];
	[[NSTask launchedTaskWithLaunchPath:path arguments:args] waitUntilExit];	
	
}

- (NSError*) copyToCloud:(NSString *)cloud worlds:(NSString *)world {
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSError* error = nil;
	
	[fileManager copyItemAtPath:[world retain] toPath:[[cloud retain] stringByAppendingPathComponent:[world lastPathComponent]] error:&error];
	
	return error;
}

- (NSError*) deleteToCloud:(NSString *)cloud worlds:(NSString *)world {
	NSFileManager* fileManager = [NSFileManager defaultManager];
	NSError* error = nil;
	
	if ([fileManager fileExistsAtPath:[world retain] isDirectory:nil]) {
		[fileManager removeItemAtPath:world error:&error];
	}
	
	return error;
}

- (NSError*) initializeCloud:(NSString *)cloud worlds:(NSString *)world {
	NSError* error = nil;
	error = [self copyToCloud:[cloud retain] worlds:[world retain]];
	
	if (error != nil)
		return error;
	
	error = [self deleteToCloud:[cloud retain] worlds:[world retain]];
	
	if (error != nil)
		return error;
	
	[self createLink:[cloud stringByAppendingPathComponent:[world lastPathComponent]] inFolder:self.WORLDS];
	
	return error;
}

- (NSError*) initializeCloudWithoutCopying:(NSString *)cloud worlds:(NSString *)world {
	NSError* error = nil;
	
	error = [self deleteToCloud:[cloud retain] worlds:[world retain]];
	
	if (error != nil)
		return error;
	
	[self createLink:[cloud stringByAppendingPathComponent:[world lastPathComponent]] inFolder:self.WORLDS];
	
	return error;
}

@end
