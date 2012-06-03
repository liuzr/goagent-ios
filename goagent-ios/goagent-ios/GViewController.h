//
//  GViewController.h
//  goagent-ios
//
//  Created by hewig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GViewController : UIViewController
{
    IBOutlet UINavigationItem *titleBar;
    IBOutlet UIBarItem *startBtn;
    IBOutlet UIBarItem *settingBtn;
}

@property (nonatomic,retain) UINavigationItem *titleBar;
@property (nonatomic,retain) UIBarItem *startBtn;
@property (nonatomic,retain) UIBarItem *settingBtn;

-(IBAction)performStartAction:(id)sender;
-(IBAction)performSettingAction:(id)sender;

@end
