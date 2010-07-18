// Created by Michael Schneider
// You can redistribute it and/or modify it under the new BSD license.

#import <Cocoa/Cocoa.h>
#import "ImageStore.h"

@interface ImageStoreSampleAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	NSMutableArray *urls;
	ImageStore* imageStore;
	
	IBOutlet NSTableView *tableView;
	IBOutlet NSButton *refreshButton;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)refresh:(id)sender;

@end
