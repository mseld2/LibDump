//
//  SourceVersionCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SourceVersionCommand.h"

@implementation SourceVersionCommand

- (instancetype) init {
    return [super initWithName: @"SourceVersionCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendString: [super description]];
    [str appendFormat: @"\n  version: %@", [self versionToString]];
    
    return str;
}

- (NSString*) versionToString {
    uint64_t a = (_version & 0xFFFFFF0000000000) >> 40;
    uint64_t b = (_version & 0x000000FFC0000000) >> 30;
    uint64_t c = (_version & 0x000000003FF00000) >> 20;
    uint64_t d = (_version & 0x00000000000FFC00) >> 10;
    uint64_t e = _version & 0x00000000000003FF;
    
    return [NSString stringWithFormat: @"%lld.%lld.%lld.%lld.%lld", a, b, c, d, e];
}

@end
