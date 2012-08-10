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

@interface GViewController ()

@end

@implementation GViewController

@synthesize titleBar,startBtn,settingBtn,settingViewController,webViewRef;


-(void)awakeFromNib
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString* pid_path=@"/tmp/goagent.pid";
    if ([fileMgr fileExistsAtPath:pid_path]) {
        [startBtn setTitle:@"Stop"];
    }
    
    settingViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"SettingViewController"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    NSString* workingDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* proxySh = [[NSBundle mainBundle] pathForResource:@"proxy" ofType:@"sh" inDirectory:@"goagent-local"];
    NSLog(@"proxySh path is %@",proxySh);
    NSTask* task = [NSTask alloc];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:[NSArray arrayWithObjects:proxySh,@"restart",nil]];
    [task setCurrentDirectoryPath:workingDir];
    [task launch];
    NSURL* url = [[NSURL alloc] initWithString:@"http://v2ex.com"];
    [webViewRef loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}

-(IBAction)performSettingAction:(id)sender
{
    NSLog(@"setting button pushed");
    [self presentModalViewController:settingViewController animated:NO];
}

@end
