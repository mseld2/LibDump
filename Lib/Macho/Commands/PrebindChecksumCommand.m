//
//  PrebindChecksumCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PrebindChecksumCommand.h"

@implementation PrebindChecksumCommand

- (instancetype) init {
    return [super initWithName: @"PrebindChecksumCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  checksum: %@", [self hexFromUInt: _checksum]];
    
    return str;
}
@end
