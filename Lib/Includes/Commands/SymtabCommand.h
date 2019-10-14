//
//  SymtabCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef SymtabCommand_h
#define SymtabCommand_h

#import "LoadCommand.h"

/*
 * The symbol table is an array of nlist_64 structs.
 *  To get the size of data associated with this command:
 *      size += (numberOfSymbols * sizeof(nlist_64)) + sizeOfStringTable
 */
@interface SymtabCommand : LoadCommand

@property NSUInteger symbolTableOffset;
@property NSUInteger numberOfSymbols;
@property NSUInteger stringTableOffset;
@property NSUInteger sizeOfStringTable;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end

#endif /* SymtabCommand_h */
