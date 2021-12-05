//
//  VisualView.m
//  modx
//
//  Created by a. p. matthews on 11/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "VisualView.h"

@implementation VisualView

@synthesize module;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		frame.size.width = 20000;
		module = NULL;
        max_freq = 100000.0;
        min_freq = 2000.0;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	NSRect frame = [self bounds];
	[[NSColor blackColor] setFill];
	NSRectFill(frame);
	float width, y, pitch, amplitude;
	int sample, i, j, frequency;
	const static int height = 20.0;
	NSRect rect;
    VOICEINFO voice[64];

	if (module != NULL)
	{
		width = frame.size.width/module->numchn;
		for (i = 0; i < module->numchn; i ++)
		{
            // get frequency
			frequency = Voice_GetFrequency(i);
            // update bounds
			/*if (frequency > max_freq)
				max_freq = frequency;
			if (frequency < min_freq)
				min_freq = frequency;*/
			pitch = log2(Voice_GetFrequency(i)/min_freq);
			y = frame.origin.y + pitch*(frame.size.height-height)/log2(max_freq/min_freq);
			rect = NSMakeRect(frame.origin.x + i*width, y, width, height);
            
            // get sample number.  TODO: use a hashtable
            Player_QueryVoices(module->numchn, voice);
            sample = 0;
            for ( j = 0; j < module->numsmp; j ++ )
                if ( voice[i].s == &module->samples[j] )
                    sample = j;

            // get volume
			amplitude = log2(Voice_RealVolume(i)+1.0)/16.0;

            // draw rectangle
			[[NSColor colorWithCalibratedHue:(1.0/(module->numsmp+1))*sample saturation:1.0
								  brightness:amplitude alpha:1.0] setFill];
			NSRectFill(rect);
		}
	}
}

@end
