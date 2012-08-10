//
//  GSettingViewController.h
//  goagent-ios
//
//  Created by hewig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "3rdparty/iniparser/iniparser.h"

@interface SettingItem : NSObject

@property (nonatomic,copy) NSString* settingKey;
@property (nonatomic,copy) NSString* settingValue;
@property (nonatomic,copy) NSString* settingDescription;

-(id)initWithKey:(NSString*)key Value:(NSString*)value Description:(NSString*)description;
@end

@interface GSettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,retain) NSMutableArray* settingSections;
@property (nonatomic,retain) NSMutableDictionary* settingDic;
@property (nonatomic,strong) IBOutlet UITableView* settingTableView;
@property (nonatomic,strong) IBOutlet UINavigationItem *titleBar;
@property (nonatomic,strong) IBOutlet UIBarItem *BackBtn;
@property (nonatomic,strong) IBOutlet UIBarItem *EditBtn;

-(IBAction)performBackAction:(id)sender;
-(IBAction)performEditAction:(id)sender;

@end
