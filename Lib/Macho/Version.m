//
//  Version.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Version.h"

@implementation Version

- (instancetype) initWithNumber: (NSUInteger) version {
    self = [super init];
    if(self) {
        _major = (version & 0xFFFF0000) >> 16;
        _minor = version & 0x0000FF00 >> 8;
        _revision = version * 0x000000FF;
    }
    
    return self;
}

- (NSString*) description {
    return [NSString stringWithFormat: @"%d.%d.%d", (unsigned int)_major, (unsigned int)_minor, (unsigned int)_revision];
}

@end
