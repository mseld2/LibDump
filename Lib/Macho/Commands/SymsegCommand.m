//
//  SymsegCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SymsegCommand.h"

@implementation SymsegCommand

- (instancetype) init {
    return [super initWithName: @"SymsegCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  symbolSegmentOffset: %@", [self hexFromUInt: _symbolSegmentOffset]];
    [str appendFormat: @"\n  sizeOfSymbolSegment: %@", [self uintToStr: _sizeOfSymbolSegment]];
    
    return str;
}
     
- (NSUInteger) getDataSize {
    return _sizeOfSymbolSegment;
}

@end
