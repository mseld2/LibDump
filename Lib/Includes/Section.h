//
//  Section.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef Section_h
#define Section_h

#import <Foundation/Foundation.h>

#import "MachOBase.h"

@interface Section : MachOBase

@property NSString* name;
@property NSString* segment;
@property NSUInteger address;
@property NSUInteger size;
@property NSUInteger fileOffset;
@property NSUInteger sectionAlignment;
@property NSUInteger relocationFileOffset;
@property NSUInteger numberOfRelocationEntries;
@property NSUInteger flags;
@property NSUInteger reserved1;
@property NSUInteger reserved2;
@property NSUInteger reserved3;

- (instancetype) init;

- (NSString*) description;

@end

#endif /* Section_h */
