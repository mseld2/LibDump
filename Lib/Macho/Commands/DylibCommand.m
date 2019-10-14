//
//  DylibCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DylibCommand.h"
#import "LoadCommand.h"

@implementation DylibCommand

- (instancetype) init {
    return [super initWithName: @"DylibCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  offsetToPathName: %@", [self hexFromUInt: _offsetToPathName]];
    [str appendFormat: @"\n  buildTime: %@", [self uintToStr: _buildTime]];
    [str appendFormat: @"\n  currentVersion: %@", [self uintToStr: _currentVersion]];
    [str appendFormat: @"\n  compatibilityVersion: %@\n}\n", [self uintToStr: _compatibilityVersion]];
    
    return str;
}

@end
