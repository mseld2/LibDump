//
//  MachOFile.h
//  LibDump
//
//  Created by Melissa Weiss on 10/12/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef MachOFile_h
#define MachOFile_h

#import <Foundation/Foundation.h>

#import "MachHeader.h"

@interface MachOFile : NSObject

@property NSString *libraryName;
@property NSString *libraryPath;
@property NSUInteger size;

@property MachHeader *machHeader;
@property NSMutableArray *sections;
@property NSMutableArray *commands;

- (instancetype) initWithLibName: (NSString*) libName;

- (instancetype) initWithLibPath: (NSString*) libPath;

- (bool) libraryExists;

- (NSArray*) getLoadedLibraries;

- (void) copyLibrary;

- (void) parse; // populates size

@end

#endif /* MachOFile_h */
