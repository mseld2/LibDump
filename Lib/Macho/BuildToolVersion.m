//
//  BuildToolVersion.m
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BuildToolVersion.h"

@implementation BuildToolVersion

- (instancetype) initWithTool: (NSUInteger) tool {
    self = [super init];
    if(self) {
        switch(tool)
        {
            case TOOL_CLANG:
                _tool = @"Clang";
                break;
            case TOOL_SWIFT:
                _tool = @"Swift";
                break;
            case TOOL_LD:
                _tool = @"ld";
                break;
            default:
                _tool = @"Unknown";
                break;
        }
    }
    
    return self;
}
@end
