//
//  LinkeditDataCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LinkeditDataCommand.h"

@implementation LinkeditDataCommand

- (instancetype) init {
    return [super initWithName: @"LinkeditDataCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  fileOffset: %@", [self hexFromUInt: _fileOffset]];
    [str appendFormat: @"\n  dataSize: %@", [self uintToStr: _dataSize]];
    
    return str;
}

- (NSUInteger) getDataSize {
    return _dataSize;
}

@end
