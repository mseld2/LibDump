//
//  NoteCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NoteCommand.h"

@implementation NoteCommand

- (instancetype) init {
    return [super initWithName: @"NoteCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendString: [super description]];
    [str appendFormat: @"\n  ownerName: %@", _ownerName];
    [str appendFormat: @"\n  fileOffset: %@", [self hexFromUInt: _fileOffset]];
    [str appendFormat: @"\n  size: %@", [self uintToStr: _size]];
    
    return str;
}

- (NSUInteger) getDataSize {
    return _size;
}

@end
