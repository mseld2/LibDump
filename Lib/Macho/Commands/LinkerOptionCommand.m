//
//  LinkerOptionCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LinkerOptionCommand.h"

@implementation LinkerOptionCommand

- (instancetype) init {
    return [super initWithName: @"LinkerOptionCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendString: [super description]];
    [str appendFormat: @"\n  numberOfStrings: %@\n}\n", [self uintToStr: _numberOfStrings]];
    
    return str;
}


@end
