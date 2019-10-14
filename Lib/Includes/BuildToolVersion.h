//
//  BuildToolVersion.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef BuildToolVersion_h
#define BuildToolVersion_h

#import <mach-o/loader.h>

@interface BuildToolVersion : NSObject

@property NSString *tool;
@property NSUInteger version;

- (instancetype) initWithTool: (NSUInteger) tool;

@end
#endif /* BuildToolVersion_h */
