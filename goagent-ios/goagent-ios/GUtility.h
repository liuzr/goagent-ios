//
//  GUtility.h
//  goagent-ios
//
//  Created by hewig on 8/15/12.
//  Copyright (c) 2012 goagent project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUtility : NSObject

+(BOOL) runTaskWithArgs:(NSArray*)args waitExit:(BOOL)waitExit;

@end
