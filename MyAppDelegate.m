//
//  MyApplication.m
//  modx
//
//  Created by a. p. matthews on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAppDelegate.h"
#include "mikmod.h"


@implementation MyAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	NSLog(@"Launch");
    /* register all the drivers */
    MikMod_RegisterAllDrivers();
	
    /* register all the module loaders */
    MikMod_RegisterAllLoaders();
	
    /* initialize the library */
    md_mode |= DMODE_SOFT_MUSIC;
	md_mode |= DMODE_HQMIXER;
	md_mode |= DMODE_INTERP;
    if (MikMod_Init(""))
        fprintf(stderr, "Could not initialize sound, reason: %s\n",
                MikMod_strerror(MikMod_errno));
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	NSLog(@"Quit");
    //MikMod_Exit();
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
	return NO;
}

@end
