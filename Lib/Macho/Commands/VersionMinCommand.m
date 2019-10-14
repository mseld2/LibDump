//
//  VersionMinCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "VersionMinCommand.h"
#import "Version.h"

@implementation VersionMinCommand

- (instancetype) init {
    return [super initWithName: @"VersionMinCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendString: [super description]];
    [str appendFormat: @"\n  version: %@", [_version description]];
    [str appendFormat: @"\n  sdk: %@", [_sdk description]];
    
    return str;
}

@end
