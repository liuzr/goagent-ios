//
//  GSettingViewController.m
//  goagent-ios
//
//  Created by hewig on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GSettingViewController.h"

@implementation SettingItem

@synthesize settingKey,settingValue,settingDescription;

-(id)initWithKey:(NSString *)key Value:(NSString *)value Description:(NSString *)description
{
    if (self)
    {
        settingKey = [[NSString alloc] initWithString:key];
        settingValue = [[NSString alloc] initWithString:value];
        settingDescription = [[NSString alloc] initWithString:description];
    }
    return self;
}

@end

@implementation GSettingViewController
@synthesize settingSections,settingDic,settingTableView,titleBar,BackBtn;

-(void)awakeFromNib
{
    NSMutableArray *keys = [[NSMutableArray alloc] init];
    NSMutableDictionary *contents = [[NSMutableDictionary alloc] init];
    
    NSString *colorKey = @"Colors";
    NSString *clothingKey = @"Clothing";
    NSString *miscKey = @"Misc";
    
    [contents setObject:[NSArray arrayWithObjects:@"Red", @"Blue", nil] forKey:colorKey];
    [contents setObject:[NSArray arrayWithObjects:@"Pants", @"Shirt", @"Socks", nil] forKey:clothingKey];
    [contents setObject:[NSArray arrayWithObjects:@"Wankle Rotary Engine", nil] forKey:miscKey];
    
    [keys addObject:clothingKey];
    [keys addObject:miscKey];
    [keys addObject:colorKey];
    
    settingSections = keys;
    settingDic = contents;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [settingSections count];
}

-(NSInteger)tableView:(UITableView *)tabbleView numberOfRowsInSection:(NSInteger)section
{
    return [[settingDic objectForKey:[settingSections objectAtIndex:section]] count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    
    NSString* key = [settingSections objectAtIndex:[indexPath section]];
    NSArray* contents = [settingDic objectForKey:key];
    
    cell.textLabel.text = [contents objectAtIndex:[indexPath row]];
    
    UITextField* myTextField = [[UITextField alloc] initWithFrame:CGRectMake(0,10,125,25)];
    myTextField.adjustsFontSizeToFitWidth = NO;
    myTextField.backgroundColor = [UIColor clearColor];
    myTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    myTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    myTextField.textAlignment = UITextAlignmentRight;
    myTextField.keyboardType = UIKeyboardTypeDefault;
    myTextField.returnKeyType = UIReturnKeyDone;
    myTextField.clearButtonMode = UITextFieldViewModeNever;
    myTextField.delegate = self;
    cell.accessoryView = myTextField;
    
    return cell;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [settingSections objectAtIndex:section];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)performBackAction:(id)sender
{
    NSLog(@"back button pushed");
    [self dismissModalViewControllerAnimated:YES];
}

@end
