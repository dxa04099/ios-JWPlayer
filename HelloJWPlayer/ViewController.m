//
//  ViewController.m
//  HelloJWPlayer
//
//  Created by subhan on 11/30/17.
//  Copyright © 2017 subhan. All rights reserved.
//

//#import "ViewController.h"
//
//@interface ViewController ()
//
//@end
//
//@implementation ViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//@end


//
//  JWPLayerViewController.m
//  HelloJWPlayer
//
//  Created by subhan on 11/30/17.
//  Copyright © 2017 subhan. All rights reserved.
//

#import "ViewController.h"
#import <JWPlayer-iOS-SDK/JWPlayerController.h>

@interface ViewController () <JWPlayerDelegate>

@property (nonatomic) JWPlayerController *player;
@property (nonatomic) UIButton *btnBack;
@property (nonatomic) UIView *v;
@property (weak, nonatomic) IBOutlet UIButton *playJWPlayer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    [self createPopulatePlayer];
//    [self.view addSubview:self.player.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)viewJWPlayerButton:(UIButton *)sender {
    [self createPopulatePlayer:@"https://origin-supersoccer-b-01.vos360.video/Content/HLS/VOD/daf82114-e53e-4e52-9701-e61457f525ca/68fb97dc-8666-635a-5742-c1ccce4088de/index.m3u8" andTitle:@"VOD video sample"];

}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)createPopulatePlayer:(NSString *)url andTitle:(NSString *)title
{
    JWConfig *config = [JWConfig new];
    config.file = url;
    config.controls = YES;
    
    self.player = [[JWPlayerController alloc] initWithConfig:config];
    
    self.btnBack = [UIButton new];
    self.btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    UIImage *closeImage = [UIImage imageNamed:@"ic_close_white.png"];
    [self.btnBack setBackgroundImage:closeImage forState:UIControlStateNormal];
    
//    [self.btnBack setTitle:@" X Close " forState:UIControlStateNormal];
    CGRect buttonFrame = self.btnBack.frame;
    buttonFrame.size = CGSizeMake(44,44);
    self.btnBack.frame = buttonFrame;
    self.btnBack.backgroundColor = [UIColor clearColor];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateFocused];
    [self.btnBack addTarget:self
                     action:@selector(fncBackTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    
//    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 30) ];
//    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:title];
//    [navbar setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:0.1]];
//    [navbar setBarTintColor:[UIColor colorWithRed:0.50f
//                                            green:0.50f
//                                             blue:0.50f
//                                            alpha:0.05f]];
//    
//    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(fncBackTapped:)];
//    navItem.leftBarButtonItem = cancelBtn;
    
//    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone:)];
//    navItem.rightBarButtonItem = doneBtn;
//
//    [navbar setItems:@[navItem]];
    
    self.v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 44)];
    self.v.backgroundColor = [UIColor blackColor];
    self.v.alpha = 0.5;
    [self.v  addSubview:self.btnBack];
    
    [self.player.view addSubview:self.v];
    
    
    self.player.delegate = self;
    
    
    
    //    self.player.openSafariOnAdClick = YES;
    self.player.forceFullScreenOnLandscape = YES;
    self.player.forceLandscapeOnFullScreen = YES;
    self.player.enterFullScreen;
    
}

-(void) fncBackTapped:(UIButton*)sender
{
    [self.player stop];
    [self.player exitFullScreen];
    [self.player.view setHidden:true];
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    
    
    [self deinitJWPlayer];
}

- (void)deinitJWPlayer
{
    if (self.player != nil) {
        [self.btnBack removeFromSuperview];
        self.btnBack = nil;
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
}

- (void)onControlBarVisible:(BOOL)isVisible
{
    if(isVisible){
        [self.v setHidden:false];
    }else{
        
        [self.v setHidden:true];
    }
}

@end
