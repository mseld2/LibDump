//
//  DyldInfoCommand.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DyldInfoCommand.h"

@implementation DyldInfoCommand

- (instancetype) init {
    return [super initWithName: @"DyldInfoCommand"];
}

- (NSString*) description {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString: [super description]];
    [str appendFormat: @"\n  rebaseInfoOffset: %@", [self hexFromUInt: _rebaseInfoOffset]];
    [str appendFormat: @"\n  sizeOfRebaseInfo: %@", [self uintToStr: _sizeOfRebaseInfo]];
    [str appendFormat: @"\n  bindingInfoOffset: %@", [self hexFromUInt: _bindingInfoOffset]];
    [str appendFormat: @"\n  sizeOfBindingInfo: %@\n}\n", [self uintToStr: _sizeOfBindingInfo]];
    [str appendFormat: @"\n  weakBindingInfoOffset: %@", [self hexFromUInt: _weakBindingInfoOffset]];
    [str appendFormat: @"\n  sizeOfWeakBindInfo: %@", [self uintToStr: _sizeOfWeakBindInfo]];
    [str appendFormat: @"\n  lazyBindingInfoOffset: %@", [self hexFromUInt: _lazyBindingInfoOffset]];
    [str appendFormat: @"\n  sizeOfLazyBindingInfo: %@\n}\n", [self uintToStr: _sizeOfLazyBindingInfo]];
    
    return str;
}

- (NSUInteger) getDataSize {
    return _sizeOfRebaseInfo + _sizeOfBindingInfo + _sizeOfWeakBindInfo + _sizeOfLazyBindingInfo;
}

@end
