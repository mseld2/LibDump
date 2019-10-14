//
//  MachHeader.m
//  LibDump
//
//  Created by Melissa Weiss on 10/12/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MachHeader.h"

const struct _MagicNumbers MagicNumbers = {
    .magic32bit = 0xfeedface,
    .magic64bit = 0xfeedfacf
};

@implementation MachHeader

- (instancetype) init {
    return [super init];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: @"MachHeader\n{\n"];
    [str appendString: @"  magic: "];
    [str appendString: [self hexFromUInt: _magic]];
    [str appendString: @"\n  cpuType: "];
    [str appendString: [self intToStr: _cpuType]];
    [str appendString: @"\n  cpuSubtype: "];
    [str appendString: [self intToStr: _cpuType]];
    [str appendString: @"\n  fileType: "];
    [str appendString: [self uintToStr: _fileType]];
    [str appendString: @"\n  numberOfLoadCommands: "];
    [str appendString: [self uintToStr: _numberOfLoadCommands]];
    [str appendString: @"\n  totalSizeOfLoadCommands: "];
    [str appendString: [self uintToStr: _totalSizeOfLoadCommands]];
    [str appendString: @"\n  flags: "];
    [str appendString: [self hexFromUInt: _flags]];
    if(_magic == MagicNumbers.magic64bit) {
        [str appendString: @"\n  reserved: "];
        [str appendString: [self hexFromUInt: _reserved]];
    }
    [str appendString: @"\n}\n"];
    
    return str;
}

@end
