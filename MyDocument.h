//
//  MyDocument.h
//  modx
//
//  Created by a. p. matthews on 11/24/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "VisualView.h"
#include "mikmod.h"

@interface MyDocument : NSDocument
{
	MODULE *module;
	int channelCount;
	int instrumentsCount;
	int samplesCount;
	int songPos;
	int patternPos;
	NSTimer *timer;
	IBOutlet VisualView *visualView;
	int frames;
	NSDate *startDate;
	float runningFPS;
}

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;

@property (nonatomic,retain) VisualView *visualView;
@property (assign) float runningFPS;
@property (assign) int channelCount;
@property (assign) int samplesCount;
@property (assign) int instrumentsCount;
@property (assign) int songPos;
@property (assign) int patternPos;

@end
