//
//  DysmbtabCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <mach-o/reloc.h>
#import <mach-o/loader.h>

#import "DysymtabCommand.h"

@implementation DysymtabCommand

- (instancetype) init {
    return [super initWithName: @"DysymtabCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  localSymbolIndex: %@", [self hexFromUInt: _localSymbolIndex]];
    [str appendFormat: @"\n  numberOfSLocalymbols: %@", [self uintToStr: _numberOfLocalSymbols]];
    [str appendFormat: @"\n  externSymbolIndex: %@", [self hexFromUInt: _externSymbolIndex]];
    [str appendFormat: @"\n  numberOfExternSymbols: %@", [self uintToStr: _numberOfExternSymbols]];
    [str appendFormat: @"\n  tocOffset: %@", [self hexFromUInt: _tocOffset]];
    [str appendFormat: @"\n  numberOfTocEntries: %@", [self uintToStr: _numberOfTocEntries]];
    [str appendFormat: @"\n  moduleTableOffset: %@", [self hexFromUInt: _moduleTableOffset]];
    [str appendFormat: @"\n  numberOfModuleTableEntries: %@", [self uintToStr: _numberOfModuleTableEntries]];
    [str appendFormat: @"\n  refSymbolTableOffset: %@", [self hexFromUInt: _refSymbolTableOffset]];
    [str appendFormat: @"\n  numberOfRefSymbolTableEntries: %@", [self uintToStr: _numberOfRefSymbolTableEntries]];
    [str appendFormat: @"\n  indirectSymbolOffset: %@", [self hexFromUInt: _indirectSymbolOffset]];
    [str appendFormat: @"\n  numberOfIndirectSymbols: %@", [self uintToStr: _numberOfIndirectSymbols]];
    [str appendFormat: @"\n  externRelocOffset: %@", [self hexFromUInt: _externRelocOffset]];
    [str appendFormat: @"\n  numberOfExternRelocEntries: %@", [self uintToStr: _numberOfExternRelocEntries]];
    [str appendFormat: @"\n  localRelocOffset: %@", [self hexFromUInt: _localRelocOffset]];
    [str appendFormat: @"\n  numberOfLocalRelocEntries: %@\n}\n", [self uintToStr: _numberOfLocalRelocEntries]];

    
    return str;
}

- (NSUInteger) getDataSize {
    // symbol table entries are accounted for in symtab_command
    NSUInteger size = _numberOfTocEntries * sizeof(struct dylib_table_of_contents);
    size += _numberOfModuleTableEntries * sizeof(struct dylib_module_64);
    size += (_numberOfExternRelocEntries + _numberOfLocalRelocEntries) * sizeof(struct relocation_info);
    
    return size;
}

@end
