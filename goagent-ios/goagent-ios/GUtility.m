//
//  GUtility.m
//  goagent-ios
//
//  Created by hewig on 8/15/12.
//  Copyright (c) 2012 goagent project. All rights reserved.
//

#import "GUtility.h"
#import "NSTask.h"

@implementation GUtility

+(BOOL)runTaskWithArgs:(NSArray *)args waitExit:(BOOL)waitExit
{
    if (args == nil)
    {
        return NO;
    }
    NSString* workingDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    @try
    {
        NSTask* task = [NSTask alloc];
        [task setLaunchPath:@"/bin/sh"];
        [task setArguments:args];
        [task setCurrentDirectoryPath:workingDir];
        [task launch];
        if (waitExit)
        {
            [task waitUntilExit];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"NSTask error occured, exception is %@, args is %@",exception,args);
        return NO;
    }

    return YES;
}

@end
