//
//  UuidCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UuidCommand.h"

@implementation UuidCommand

- (instancetype) init {
    return [super initWithName: @"UuidCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  uuid: %@", [_uuid description]];
    
    return str;
}

@end
