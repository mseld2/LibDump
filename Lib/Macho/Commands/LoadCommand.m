//
//  LoadCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoadCommand.h"

@implementation LoadCommand

- (instancetype) initWithName: (NSString*) commandName {
    self = [super init];
    if(self) {
        _commandType = commandName;
    }
    
    return self;
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];

    [str appendFormat: @"%@\n{\n", _commandType];
    [str appendFormat: @"\n  command: %@", [self hexFromUInt: self.command]];
    [str appendFormat: @"\n  commandSize: %@", [self uintToStr: self.commandSize]];
    
    return str;
}

- (NSUInteger) getDataSize {
    return 0;
}

@end
