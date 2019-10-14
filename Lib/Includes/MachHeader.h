//
//  MachHeader.h
//  LibDump
//
//  Created by Melissa Weiss on 10/12/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef MachHeader_h
#define MachHeader_h

#import "MachOBase.h"

/*
 * struct mach_header.
 *  See mach-o/loader.h for declaration.
 */

extern const struct _MagicNumbers {
    uint32_t const magic32bit;
    uint32_t const magic64bit;
} MagicNumbers;


@interface MachHeader : MachOBase

@property NSUInteger magic;
@property NSInteger cpuType; // CPU specifier
@property NSInteger cpuSubtype; // machine specifier
@property NSUInteger fileType;
@property NSUInteger numberOfLoadCommands;
@property NSUInteger totalSizeOfLoadCommands; // can be used to skip to segments
@property NSUInteger flags; // not sure how to interpret
@property NSUInteger reserved; // this only for 64-bit

- (instancetype) init;

- (NSString*) description;

@end

#endif /* MachHeader_h */
