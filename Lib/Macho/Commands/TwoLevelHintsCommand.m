//
//  TwoLevelHintsCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <mach-o/loader.h>

#import "TwoLevelHintsCommand.h"

@implementation TwoLevelHintsCommand

- (instancetype) init {
    return [super initWithName: @"TwoLevelHintsCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  hintsTableOffset: %@", [self hexFromUInt: _hintsTableOffset]];
    [str appendFormat: @"\n  numberOfHints: %@", [self uintToStr: _numberOfHints]];
    
    return str;
}

- (NSUInteger) getDataSize {
    return _numberOfHints  * sizeof(struct twolevel_hint);
}

@end
