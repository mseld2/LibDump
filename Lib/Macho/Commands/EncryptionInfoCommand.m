//
//  EncryptionInfoCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EncryptionInfoCommand.h"

@implementation EncryptionInfoCommand

- (instancetype) init {
    return [super initWithName: @"EncryptionInfoCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  fileOffset: %@", [self hexFromUInt: _fileOffset]];
    [str appendFormat: @"\n  dataSize: %@", [self uintToStr: _dataSize]];
    [str appendFormat: @"\n  cryptId: %@", [self uintToStr: _cryptId]];
    
    return str;
}

- (NSUInteger) getDataSize {
    return _dataSize;
}

@end
