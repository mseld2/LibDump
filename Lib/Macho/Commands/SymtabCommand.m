//
//  SymtabCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <mach-o/nlist.h>

#import "SymtabCommand.h"

@implementation SymtabCommand

- (instancetype) init {
    return [super initWithName: @"SymtabCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  symbolTableOffset: %@", [self hexFromUInt: _symbolTableOffset]];
    [str appendFormat: @"\n  numberOfSymbols: %@", [self uintToStr: _numberOfSymbols]];
    [str appendFormat: @"\n  stringTableOffset: %@", [self hexFromUInt: _stringTableOffset]];
    [str appendFormat: @"\n  sizeOfStringTable: %@\n}\n", [self uintToStr: _sizeOfStringTable]];
    
    return str;
}

- (NSUInteger) getDataSize {
    return _numberOfSymbols * sizeof(struct nlist_64) + _sizeOfStringTable;
}

@end
