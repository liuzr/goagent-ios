//
//  GViewController.m
//  goagent-ios
//
//  Created by hewig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GViewController.h"
#import "GSettingViewController.h"
#import "NSTask.h"
#import "GConfig.h"

@interface GViewController ()

@end

@implementation GViewController

@synthesize titleBar,startBtn,settingBtn,settingViewController,webViewRef,statusMessage,copyleftMessage;


-(void)awakeFromNib
{
    settingViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self isRunning])
    {
        [statusMessage setText:[NSString stringWithFormat:@"GoAgent is Runing"]];
    }
    else [statusMessage setText:[NSString stringWithFormat:@"GoAgent is Stopped"]];
    [self updateStartBtnTitle];
    [self.webViewRef setHidden:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction)performStartAction:(id)sender
{
    NSLog(@"start button pushed");

    NSString* actionCmd = nil;
    if ([self isRunning])
    {
        actionCmd = CONTROL_CMD_STOP;
    }
    else
    {
        actionCmd = CONTROL_CMD_START;
    }
    
    NSString* workingDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* controlSh = [[NSBundle mainBundle] pathForResource:CONTROL_SCRIPT_NAME
                                                          ofType:CONTROL_SCRIPT_TYPE
                                                     inDirectory:GOAGENT_LOCAL_PATH];
    NSLog(@"controlSh path is %@",controlSh);
    
    NSTask* task = [NSTask alloc];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:[NSArray arrayWithObjects:controlSh,actionCmd,nil]];
    [task setCurrentDirectoryPath:workingDir];
    [task launch];
    
    [self updateStartBtnTitle];
    [webViewRef setHidden:NO];
    [statusMessage setHidden:YES];
    [copyleftMessage setHidden:YES];
    NSURL* url = [[NSURL alloc] initWithString:@"https://code.google.com/p/goagent"];
    [webViewRef loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}

-(IBAction)performSettingAction:(id)sender
{
    NSLog(@"setting button pushed");
    [self presentModalViewController:settingViewController animated:NO];
}

-(void)updateStartBtnTitle;
{
    if ([self isRunning])
        startBtn.title = @"Stop";
    else startBtn.title = @"Start";
}

-(BOOL)isRunning
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:GOAGENT_PID_PATH])
        return YES;
    else return NO;
}
@end
