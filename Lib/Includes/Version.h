//
//  Version.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef Version_h
#define Version_h

@interface Version : NSObject

@property NSUInteger major;
@property NSUInteger minor;
@property NSUInteger revision;

- (instancetype) initWithNumber: (NSUInteger) version;

- (NSString*) description;

@end
#endif /* Version_h */
