//
//  SegmentCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SegmentCommand.h"
#import "LoadCommand.h"
#import "Section.h"

@implementation SegmentCommand

- (instancetype) init {
    self = [super initWithName: @"SegmentCommand"];
    if(self) {
        _sections = [NSMutableArray array];
    }
    
    return self;
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendString: [super description]];
    [str appendFormat: @"\n  name: %@", _name];
    [str appendFormat: @"\n  vmAddr: %@", [self hexFromUInt: _vmAddress]];
    [str appendFormat: @"\n  vmSize: %@", [self uintToStr: _vmSize]];
    [str appendFormat: @"\n  fileOffset: %@", [self hexFromUInt: _fileOffset]];
    [str appendFormat: @"\n  fileSize: %@", [self uintToStr: _fileSize]];
    [str appendFormat: @"\n  maxVmProtection %@", [self uintToStr: _maxVmProtection]];
    [str appendFormat: @"\n  initVmProtection: %@", [self uintToStr: _initVmProtection]];
    [str appendFormat: @"\n  numberOfSections: %@", [self uintToStr: _numberOfSections]];
    [str appendFormat: @"\n  flags: %@\n}\n", [self hexFromUInt: _flags]];
    
    return str;
}

- (NSUInteger) getDataSize {
    NSUInteger size = 0;
    for(uint32_t  index = 0; index< _numberOfSections; ++index) {
        Section *section = [_sections objectAtIndex: index];
        size += section.size;
    }
        
    return size;
}

@end
