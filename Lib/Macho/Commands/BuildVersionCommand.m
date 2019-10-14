//
//  BuildVersionCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <mach-o/loader.h>

#import "BuildToolVersion.h"
#import "BuildVersionCommand.h"
#import "Version.h"

@implementation BuildVersionCommand

- (instancetype) initWithPlatform: (NSUInteger) platformCode {
    self = [super initWithName: @"BuildVersionCommand"];
    if(self) {
        _platform = [self getPlatformName: platformCode];
    }
    
    return self;
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendString: [super description]];
    [str appendString: _platform];
    [str appendFormat: @"\n  version: %@", [_minOs description]];
    [str appendFormat: @"\n  sdk: %@", [_sdk description]];
    [str appendFormat: @"\n  numberOfTools: %d", (unsigned int)[_tools count]];
    
    return str;
}

- (NSString*) getPlatformName: (NSUInteger) platformCode {
    switch(platformCode)
    {
        case PLATFORM_IOS:
            return @"iOS";
        case PLATFORM_MACOS:
            return @"Mac OS";
        case PLATFORM_TVOS:
            return @"TV OS";
        case PLATFORM_WATCHOS:
            return @"Wathc OS";
        case PLATFORM_IOSSIMULATOR:
            return @"iOS Simulator";
        case PLATFORM_TVOSSIMULATOR:
            return @"TV OS Simulator";
        case PLATFORM_WATCHOSSIMULATOR:
            return @"Watch OS Simulator";
        case PLATFORM_BRIDGEOS:
            return @"Bridge OS";
        case PLATFORM_MACCATALYST:
            return @"Mac Catalyst";
        case PLATFORM_DRIVERKIT:
            return @"Driver Kit";
        default:
            return @"Unknown";
    }
}

@end
