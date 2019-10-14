//
//  TwoLevelHintsCommand.h
//  LibDump
//
//  Created by Melissa Weiss on 10/13/19.
//  Copyright © 2019 All Tyme. All rights reserved.
//

#ifndef TwoLevelHintsCommand_h
#define TwoLevelHintsCommand_h

#import "LoadCommand.h"

/*
 * Entries in the two-level namespace are twolevel_hint structs.
 *  To find the data size
 *      size += numberOfHints * sizeof(struct twolevel_hint)
 */
@interface TwoLevelHintsCommand : LoadCommand

@property NSUInteger hintsTableOffset;
@property NSUInteger numberOfHints;

- (instancetype) init;

- (NSString*) description;

- (NSUInteger) getDataSize;

@end
#endif /* TwoLevelHintsCommand_h */
