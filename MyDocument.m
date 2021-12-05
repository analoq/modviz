//
//  MyDocument.m
//  modx
//
//  Created by a. p. matthews on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyDocument.h"

@implementation MyDocument

@synthesize visualView;
@synthesize channelCount;
@synthesize samplesCount;
@synthesize instrumentsCount;
@synthesize songPos;
@synthesize patternPos;
@synthesize runningFPS;

- (id)init
{
    self = [super init];
    if (self)
	{
		module = NULL;
		songPos = 0;
		patternPos = 0;
		runningFPS = 0.0;
		channelCount = 0;
		samplesCount = 0;
		instrumentsCount = 0;
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"Module";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    if ( outError != NULL )
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
    module = Player_Load((char *)[[[self fileURL] path] UTF8String], 64, 0);
	if (module != NULL)
	{
		self.channelCount = module->numchn;
		self.samplesCount = module->numsmp;
		self.instrumentsCount = module->numins;
		return TRUE;
	}
	else
		return FALSE;
}

- (void)update
{
	if (Player_Active())
	{
		self.songPos = module->sngpos;
		self.patternPos = module->patpos;

		[visualView setNeedsDisplay:YES];
		frames ++;
		NSTimeInterval delta = -[startDate timeIntervalSinceNow];
		self.runningFPS = (double)frames/delta;
	}
}

- (IBAction)play:(id)sender
{
	frames = 0;
	startDate = [[NSDate date] retain];
	Player_SetVolume(64);
	Player_Start(module);
	[visualView setModule:module];
	timer = [NSTimer scheduledTimerWithTimeInterval:1.0/60.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (IBAction)stop:(id)sender
{
	Player_Stop();
	[startDate release];
	[timer invalidate];
}
		 
- (void)windowWillClose:(NSNotification *)notification
{
	NSLog(@"windowWillClose");
	[timer invalidate];
	[startDate release];
	Player_Stop();
	Player_Free(module);	
}

@end
