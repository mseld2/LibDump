//
//  MachOBase.h
//  LibDump
//
//  Created by Melissa Weiss on 10/12/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef MachOBase_h
#define MachOBase_h

#import <Foundation/Foundation.h>

@interface MachOBase : NSObject

- (instancetype) init;

- (NSString*) hexFromUInt: (NSUInteger) value;

- (NSString*) hexFromInt: (NSInteger) value;

- (NSString*) uintToStr: (NSUInteger) value;

- (NSString*) intToStr: (NSInteger) value;
@end

#endif /* MachOBase_h */
