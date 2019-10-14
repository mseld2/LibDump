//
//  BasicCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BasicCommand.h"

@implementation BasicCommand

- (instancetype) initWithName: (NSString*) commandName {
    return [super initWithName: commandName];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendString: [super description]];
    [str appendFormat: @"\n  nameOffset: %@\n}\n", [self hexFromUInt: _nameOffset]];
    
    return str;
}

@end
