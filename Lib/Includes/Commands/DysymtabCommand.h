//
//  DysymtabCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef DysymtabCommand_h
#define DysymtabCommand_h

#import "LoadCommand.h"

/*
 * The symbols are accounted for in the symbol table.
 * To find size of data associated with this command
 *  size += (numberOfTocEntries * sizeof(struct dylib_table_of_contents))
 *  size += (numberOfModuleTableEntries * sizeof(struct dylib_module_64))
 *  size += (numberOfRefSymbolTableEntries * sizeof(struct dylib_reference))
 *  size += (numberOfExternalRelocEntries + sizeof(struct reloc_info))
 *  size += (numberOfLocalRelocEntries + sizeof(struct reloc_info))
 */
@interface DysymtabCommand : LoadCommand

@property NSUInteger localSymbolIndex;
@property NSUInteger numberOfLocalSymbols;

@property NSUInteger externSymbolIndex;
@property NSUInteger numberOfExternSymbols;

@property NSUInteger tocOffset;
@property NSUInteger numberOfTocEntries;

@property NSUInteger moduleTableOffset;
@property NSUInteger numberOfModuleTableEntries;

@property NSUInteger refSymbolTableOffset;
@property NSUInteger numberOfRefSymbolTableEntries;

@property NSUInteger indirectSymbolOffset;
@property NSUInteger numberOfIndirectSymbols;

@property NSUInteger externRelocOffset;
@property NSUInteger numberOfExternRelocEntries;

@property NSUInteger localRelocOffset;
@property NSUInteger numberOfLocalRelocEntries;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;


@end

#endif /* DysymtabCommand_h */
