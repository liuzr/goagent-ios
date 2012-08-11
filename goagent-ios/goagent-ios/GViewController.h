//
//  GViewController.h
//  goagent-ios
//
//  Created by hewig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GViewController : UIViewController

@property (nonatomic,strong) IBOutlet UINavigationItem *titleBar;
@property (nonatomic,strong) IBOutlet UIBarItem *startBtn;
@property (nonatomic,strong) IBOutlet UIBarItem *settingBtn;
@property (nonatomic,strong) IBOutlet UIWebView* webViewRef;
@property (nonatomic,strong) IBOutlet UILabel* statusMessage;
@property (nonatomic,strong) IBOutlet UITextView* copyleftMessage;
@property (nonatomic,strong) UIViewController* settingViewController;

-(IBAction)performStartAction:(id)sender;
-(IBAction)performSettingAction:(id)sender;
-(BOOL)isRunning;

@end
