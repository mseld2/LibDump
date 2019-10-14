//
//  NoteCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef NoteCommand_h
#define NoteCommand_h

#import "LoadCommand.h"

@interface NoteCommand : LoadCommand

@property NSString *ownerName;
@property NSUInteger fileOffset;
@property NSUInteger size;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end
#endif /* NoteCommand_h */
