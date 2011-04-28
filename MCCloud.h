//
//  MCCloud.h
//  MinecraftInTheCloud
//
//  Created by Rishi Shah on 2/4/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MCCloud : NSObject

// Clouds
@property (copy) NSString* DROPBOX;

// MineCraft
@property (readonly, copy) NSString* MINECRAFT;
@property (readonly, copy) NSString* WORLD1;
@property (readonly, copy) NSString* WORLD2;
@property (readonly, copy) NSString* WORLD3;
@property (readonly, copy) NSString* WORLD4;
@property (readonly, copy) NSString* WORLD5;
@property (readonly, copy) NSString* WORLDS;

// Methods
- (void) createLink: (NSString*)destFolder inFolder:(NSString *)parentFolder;
- (NSError*) initializeCloud:(NSString *)cloud worlds:(NSString *)world;
- (NSError*) initializeCloudWithoutCopying:(NSString *)cloud worlds:(NSString *)world;

@end
