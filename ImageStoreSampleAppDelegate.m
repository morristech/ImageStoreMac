// Created by Michael Schneider
// You can redistribute it and/or modify it under the new BSD license.

#import "ImageStoreSampleAppDelegate.h"

@implementation ImageStoreSampleAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
}

- (id) init 
{
	if (self = [super init]) {
		urls = [[NSMutableArray alloc] init];
		
		if (!imageStore) {
			imageStore = [[ImageStore alloc] init];
			imageStore.delegate = self;
		}
	}
	return self;
}

- (void)imageStoreDidGetNewImage:(ImageStore*)sender 
							 url:(NSString*)url
{
	[tableView reloadData];
}

- (int)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [urls count];
}

- (id)tableView:(NSTableView *)tableView
objectValueForTableColumn:(NSTableColumn *)tableColumn
			row:(int)row
{
	return NULL;
}

- (void)tableView:(NSTableView *)view
  willDisplayCell:(id)cell
   forTableColumn:(NSTableColumn *)col
			  row:(int)row 
{
	if([[col identifier] isEqual:@"url"]) {
		[cell setObjectValue:[urls objectAtIndex:row]];
	} else {
		if(![cell image]) {
			[cell setImage: [imageStore getImage:[NSString stringWithFormat:@"%@/favicon.ico", [urls objectAtIndex:row]]]];				
		}
	}
	
}

- (IBAction)refresh:(id)sender 
{
	[urls release];
	urls = [[NSMutableArray alloc] init];
	[urls addObject:@"http://www.google.de"];
	[urls addObject:@"http://www.web.de"];
	[urls addObject:@"http://www.bitsundso.de"];
	[urls addObject:@"http://www.yahoo.de"];
	[urls addObject:@"http://www.cocoadev.com"];
	[urls addObject:@"http://www.facebook.com"];
	[urls addObject:@"http://www.amazon.com"];
	[urls addObject:@"http://www.yahoo.com"];
	[urls addObject:@"http://www.github.com.com"];
	[urls addObject:@"http://www.literatureandlatte.com"];
	[urls addObject:@"http://www.apple.com"];
	[urls addObject:@"http://www.imdb.com"];
	[urls addObject:@"http://www.heise.de"];
	[urls addObject:@"http://www.readitlaterlist.com"];
	[tableView reloadData];
}

@end
