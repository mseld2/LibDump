//
//  EntryPointCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EntryPointCommand.h"

@implementation EntryPointCommand

- (instancetype) init {
    return [super initWithName: @"EntryPointCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  entryOffset: %@", [self hexFromUInt: _entryOffset]];
    [str appendFormat: @"\n  stackSize: %@\n}\n", [self uintToStr: _stackSize]];
    
    return str;
}

@end
