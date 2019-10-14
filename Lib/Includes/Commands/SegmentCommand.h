//
//  SegmentCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef SegmentCommand_h
#define SegmentCommand_h

#import <Foundation/Foundation.h>

#import "LoadCommand.h"

/*
 * If the segment has sections, the sections immediately follow the segment.
 * The size of the section is reflected in section.size.
 * To find total size of segment
 *  size += segment.cmdSize;
 *  For each section in segment (0 until segment.nsects):
 *      size += section.size;
 *
 */
@interface SegmentCommand: LoadCommand

@property NSString *name;
@property NSUInteger vmAddress;
@property NSUInteger vmSize;
@property NSUInteger fileOffset;
@property NSUInteger fileSize;
@property NSUInteger maxVmProtection;
@property NSUInteger initVmProtection;
@property NSUInteger numberOfSections;
@property NSUInteger flags;
@property NSMutableArray *sections;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end

#endif /* SegmentCommand_h */
