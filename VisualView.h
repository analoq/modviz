//
//  VisualView.h
//  modx
//
//  Created by a. p. matthews on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#include "mikmod.h"
#import <Cocoa/Cocoa.h>


@interface VisualView : NSView
{
	MODULE *module;
	float max_freq;
	float min_freq;
}

@property (assign) MODULE *module;

@end
