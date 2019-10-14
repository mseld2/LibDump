//
//  FvmfileCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FvmfileCommand.h"

@implementation FvmfileCommand

- (instancetype) init {
    return [super initWithName: @"FvmfileCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  headerAddress: %@\n}\n", [self hexFromUInt: _headerAddress]];
    
    return str;
}

@end
