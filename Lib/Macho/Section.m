//
//  Section.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Section.h"

@implementation Section

- (instancetype) init {
    return [super init];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: @"Section\n{\n"];
    [str appendFormat: @"  name: %@", _name];
    [str appendFormat: @"  segment: %@", _segment];
    [str appendFormat: @"\n  addr: %@", [self hexFromUInt: _address]];
    [str appendFormat: @"\n  size: %@", [self uintToStr: _size]];
    [str appendFormat: @"\n  fileOffset: %@", [self hexFromUInt: _fileOffset]];
    [str appendFormat: @"\n  sectionAlignment: %@", [self uintToStr: _sectionAlignment]];
    [str appendFormat: @"\n  relocationFileOffset: %@", [self hexFromUInt: _relocationFileOffset]];
    [str appendFormat: @"\n  numberOfRelocationEntries: %@", [self uintToStr: _numberOfRelocationEntries]];
    [str appendFormat: @"\n  flags: %@", [self hexFromUInt: _flags]];
    [str appendFormat: @"\n  reserved1: %@", [self hexFromUInt: _reserved1]];
    [str appendFormat: @"\n  reserved2: %@", [self uintToStr: _reserved2]];
    [str appendFormat: @"\n  reserved3: %@\n}\n", [self uintToStr: _reserved3]];
    
    return str;
}

@end
