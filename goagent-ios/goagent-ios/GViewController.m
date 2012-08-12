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
#import "3rdparty/ASIHTTPRequest/ASIHTTPRequest.h"

@interface GViewController ()

@end

@implementation GViewController

@synthesize titleBar,startBtn,settingBtn,settingViewController,webViewRef,statusMessage,copyleftMessage;

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)awakeFromNib
{
    settingViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [webViewRef setHidden:YES];
    [self updateUIStatus];
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
        [self loadHomePage];
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
    [task waitUntilExit];
    
    [self updateUIStatus];
}

-(IBAction)performSettingAction:(id)sender
{
    NSLog(@"setting button pushed");
    [self presentModalViewController:settingViewController animated:NO];
}

-(void)updateUIStatus;
{
    if ([self isRunning])
    {
        [startBtn setTitle:@"Stop"];
        [statusMessage setText:[NSString stringWithFormat:@"GoAgent is Runing"]];
        
        [webViewRef setHidden:NO];
        [statusMessage setHidden:YES];
        [copyleftMessage setHidden:YES];
    }
    else
    {
        [startBtn setTitle:@"Start"];
        [statusMessage setText:[NSString stringWithFormat:@"GoAgent is Stopped"]];
        
        [webViewRef setHidden:YES];
        [statusMessage setHidden:NO];
        [copyleftMessage setHidden:NO];
    }
}

-(BOOL)isRunning
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:GOAGENT_PID_PATH])
        return YES;
    else return NO;
}

-(void)loadHomePage
{
    ASIHTTPRequest __weak *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"https://code.google.com/p/goagent"]];
    [request setProxyHost:@"127.0.0.1"];
    [request setProxyPort:8087];
    [request setProxyType:@"HTTP"];
    [request setCompletionBlock:^
    {
        NSString *responseString = [request responseString];
        [webViewRef loadHTMLString:responseString baseURL:nil];
    }];
    [request startAsynchronous];
}
@end
