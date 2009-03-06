//
//  YubNubSearch.m
//
//  Copyright (c) 2006 Tildesoft. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense,
//  and/or sell copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.

#import "YubNubSearch.h"
#import "MethodSwizzle.h"

@interface NSObject (YNS_Patch)
- (NSURL *)YNS_URLWithSearchCriteria:(NSString *)text;
- (NSString *)YNS_localSearchStringFromWebSearchString:(NSString *)searchString;
- (void)YNS_layOutInputFields;
@end

@implementation YubNubSearch
+ (void) load {
	BOOL b;
	b = MethodSwizzle(NSClassFromString(@"GoogleSearchChannel"), @selector(URLWithSearchCriteria:), @selector(YNS_URLWithSearchCriteria:));
	b = b && MethodSwizzle(NSClassFromString(@"ToolbarController"), @selector(layOutInputFields), @selector(YNS_layOutInputFields));
	if (!b) {
		NSLog(@"YubNubSearch: installation failed");
	}
	// ignore the result from the following swizzle, it doesn't particularly matter if it fails
	MethodSwizzle(NSClassFromString(@"GoogleSearchChannel"), @selector(localSearchStringFromWebSearchString:),
				  @selector(YNS_localSearchStringFromWebSearchString:));
}
@end

@implementation NSObject (YNS_Patch)
- (NSURL *)YNS_URLWithSearchCriteria:(NSString *)text {
	if ([text hasPrefix:@"g "]) {
		text = [text substringFromIndex:2];
		return [self YNS_URLWithSearchCriteria:text];
	} else {
		NSMutableString *mText = [[text mutableCopy] autorelease];
		[mText replaceOccurrencesOfString:@" " withString:@"+" options:NSLiteralSearch range:NSMakeRange(0, [mText length])];
		text = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)mText,
																   NULL, (CFStringRef)@"&;", kCFStringEncodingUTF8);
		[text autorelease];
		return [NSURL URLWithString:[@"http://yubnub.org/parser/parse?command=" stringByAppendingString:text]];
	}
}

- (NSString *)YNS_localSearchStringFromWebSearchString:(NSString *)searchString {
	// always assume the first word is a command
	NSArray *components = [[searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsSeparatedByString:@" "];
	if ([components count] > 1) {
		searchString = [[components subarrayWithRange:NSMakeRange(1, [components count]-1)] componentsJoinedByString:@" "];
	}
	return [self YNS_localSearchStringFromWebSearchString:searchString];
}

- (void)YNS_layOutInputFields {
	[self YNS_layOutInputFields];
	NSSearchField *field = nil;
	object_getInstanceVariable(self, "searchField", (void**)&field);
	[[field cell] setPlaceholderString:@"YubNub"];
}
@end
