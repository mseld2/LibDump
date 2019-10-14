//
//  MachOBase.m
//  LibDump
//
//  Created by Melissa Weiss on 10/12/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MachOBase.h"

@implementation MachOBase

- (instancetype) init {
    return [super init];
}

- (NSString*) hexFromUInt:(NSUInteger)value {
    return [NSString stringWithFormat: @"0x%X", (unsigned int)value];
}

- (NSString*) hexFromInt:(NSInteger)value {
    return [NSString stringWithFormat: @"0x%X", (int)value];
}

- (NSString*) uintToStr:(NSUInteger)value {
    return [NSString stringWithFormat: @"%d", (unsigned int)value];
}

- (NSString*) intToStr:(NSInteger)value {
    return [NSString stringWithFormat: @"%d", (int)value];}

@end
