//
//  GViewController.m
//  goagent-ios
//
//  Created by hewig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GViewController.h"
#import "GSettingViewController.h"

@interface GViewController ()

@end

@implementation GViewController

@synthesize titleBar,startBtn,settingBtn,settingViewController;


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
}

-(IBAction)performSettingAction:(id)sender
{
    NSLog(@"setting button pushed");
    [self presentModalViewController:settingViewController animated:NO];
}

@end
