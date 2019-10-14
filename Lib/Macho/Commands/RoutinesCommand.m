//
//  RoutinesCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RoutinesCommand.h"

@implementation RoutinesCommand

- (instancetype) init {
    return [super initWithName: @"RoutinesCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  initAddress: %@", [self hexFromUInt: _initAddress]];
    [str appendFormat: @"\n  initIndex: %@", [self hexFromUInt: _initIndex]];
    [str appendFormat: @"\n  reserved1: %@", [self uintToStr: _reserved1]];
    [str appendFormat: @"\n  reserved2: %@", [self uintToStr: _reserved2]];
    [str appendFormat: @"\n  reserved3: %@", [self uintToStr: _reserved3]];
    [str appendFormat: @"\n  reserved4: %@", [self uintToStr: _reserved4]];
    [str appendFormat: @"\n  reserved5: %@", [self uintToStr: _reserved5]];
    [str appendFormat: @"\n  reserved6: %@\n}\n", [self uintToStr: _reserved6]];
    
    return str;
}

@end
