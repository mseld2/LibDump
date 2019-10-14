//
//  PreboundDylibCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PreboundDylibCommand.h"

@implementation PreboundDylibCommand

- (instancetype) init {
    return [super initWithName: @"PreboundDylibCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  name: %@\n}\n", [self hexFromUInt: self.nameOffset]];
    [str appendFormat: @"\n  numberOfModules: %@", [self uintToStr: _numberOfModules]];
    [str appendFormat: @"\n  linkedModules: %@\n}\n", [self uintToStr: _linkedModules]];
    
    return str;
}

@end
