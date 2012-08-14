#import "BBWeeAppController-Protocol.h"
#import <stdlib.h>
#import <sys/stat.h>

static NSBundle *_goagentwidgetWeeAppBundle = nil;

@interface goagentwidgetController: NSObject <BBWeeAppController> {
	UIView *_view;
	UIImageView *_backgroundView;
}
@property (nonatomic, retain) UIView *view;
@end

@implementation goagentwidgetController
@synthesize view = _view;

+ (void)initialize {
	_goagentwidgetWeeAppBundle = [[NSBundle bundleForClass:[self class]] retain];
}

- (id)init {
	if((self = [super init]) != nil) {
		
	} return self;
}

- (void)dealloc {
	[_view release];
	[_backgroundView release];
	[super dealloc];
}

- (void)loadFullView {
	// Add subviews to _backgroundView (or _view) here.
    UIButton *toggleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	struct stat st;
    NSString *btnTitle = nil;
    int action;
	if(stat("/tmp/goagent.pid",&st)==0)
    {    
        btnTitle =  @"Stop GoAgent";
        action = 0;
    }
    else 
    {
        btnTitle = @"Start GoAgent";
        action = 1;
    }
    [toggleBtn setTitle:btnTitle  forState:UIControlStateNormal];
    toggleBtn.tag = action;
    [toggleBtn addTarget:self action:@selector(runGoAgent:) forControlEvents:UIControlEventTouchDown];
    toggleBtn.frame = CGRectMake(_view.frame.size.width/2-70, 0, 140, 60);
	[_view addSubview:toggleBtn];
}

- (void)loadPlaceholderView {
	// All widgets are 316 points wide. Image size calculations match those of the Stocks widget.
	_view = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, {316.f, [self viewHeight]}}];
	_view.autoresizingMask = UIViewAutoresizingFlexibleWidth;

	UIImage *bgImg = [UIImage imageWithContentsOfFile:@"/System/Library/WeeAppPlugins/StocksWeeApp.bundle/WeeAppBackground.png"];
	UIImage *stretchableBgImg = [bgImg stretchableImageWithLeftCapWidth:floorf(bgImg.size.width / 2.f) topCapHeight:floorf(bgImg.size.height / 2.f)];
	_backgroundView = [[UIImageView alloc] initWithImage:stretchableBgImg];
	_backgroundView.frame = CGRectInset(_view.bounds, 2.f, 0.f);
	_backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[_view addSubview:_backgroundView];
}

- (void)unloadView {
	[_view release];
	_view = nil;
	[_backgroundView release];
	_backgroundView = nil;
}

- (float)viewHeight {
	return 71.f;
}

- (void)runGoAgent:(id)sender {
    UIButton* btn = (UIButton*)sender;
    NSLog(@"button.tag = %d",btn.tag);
    if (btn.tag == 1)
    {
        system("sh /Applications/goagent-ios.app/goagent-local/proxy.sh start");
        [btn setTitle:@"Stop GoAgent" forState:UIControlStateNormal];
    }
    else 
    {
        system("sh /Applications/goagent-ios.app/goagent-local/proxy.sh stop");
        [btn setTitle:@"Start GoAgent" forState:UIControlStateNormal];
    }
}
@end
