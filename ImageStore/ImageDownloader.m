// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the new BSD license.

#import "ImageDownloader.h"


@implementation ImageDownloader

@synthesize image;
@synthesize url;

- (id)init
{
	if (self = [super init]) {
		;
	}
	return self;
}

- (id)initWithDelegate:(id)aDelegate;
{
	if ([self init]) {
		delegate = aDelegate;
	}
	return self;
}

- (void)dealloc
{
	[url release];
	[image release];
	[conn release];
	[super dealloc];
}

- (void)start:(NSString*)anUrl
{
	[url autorelease];
	[conn autorelease];
	url = [anUrl retain];
	
	conn = [[HttpClient alloc] initWithDelegate:self];
	[conn get:url parameters:nil];
}

+ (ImageDownloader*)imageDownloaderWithDelegate:(id)aDelegate url:(NSString*)url
{
	ImageDownloader* d = [[[ImageDownloader alloc] initWithDelegate:aDelegate] autorelease];
	[d start:url];
	return d;
}

- (void)httpClientSucceeded:(HttpClient*)sender response:(NSHTTPURLResponse*)response data:(NSData*)data
{
	[image release];
	image = [[NSImage alloc] initWithData:data];
	
	// If it is no image, display a place holder image
	if (!image) {
		image = [NSImage imageNamed:@"blank_favicon.png"];
	}
	
	[conn autorelease];
	conn = nil;
	
	if ([delegate respondsToSelector:@selector(imageDownloaderDidSucceed:)]) {
		[delegate imageDownloaderDidSucceed:self];
	}
	

}

- (void)httpClientFailed:(HttpClient*)sender error:(NSError*)error
{
	[conn autorelease];
	conn = nil;
	
	if ([delegate respondsToSelector:@selector(imageDownloaderDidFail:error:)]) {
		[delegate imageDownloaderDidFail:self error:error];
	}
}

@end
