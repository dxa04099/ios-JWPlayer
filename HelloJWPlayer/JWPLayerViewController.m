//
//  JWPLayerViewController.m
//  HelloJWPlayer
//
//  Created by subhan on 11/30/17.
//  Copyright © 2017 subhan. All rights reserved.
//

#import "JWPLayerViewController.h"
#import <JWPlayer-iOS-SDK/JWPlayerController.h>

@interface JWPLayerViewController () <JWPlayerDelegate>

@property (nonatomic) JWPlayerController *player;
@property (nonatomic) UIButton *btnBack;
@property (nonatomic) UIView *v;

@end

@implementation JWPLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    //    [super viewWillAppear:animated];
    [self createPopulatePlayer:_streamUrl andTitle:@"VOD video sample"];
    [self.view addSubview:self.player.view];
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
    buttonFrame.size = CGSizeMake(45 ,45);
    self.btnBack.frame = buttonFrame;
    [self.btnBack.layer setFrame:CGRectMake(20, 0, 45, 45)];
    self.btnBack.backgroundColor = [UIColor clearColor];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateFocused];
    [self.btnBack addTarget:self
                     action:@selector(fncBackTapped:)
           forControlEvents:UIControlEventTouchUpInside];
    
    self.v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.height, 44)];
    self.v.backgroundColor = [UIColor blackColor];
    self.v.alpha = 0.5;
    
    [self.v addSubview:self.btnBack];
    [self.player.view addSubview:self.v];
    
    
    self.player.delegate = self;
    
    CGRect frame = self.view.bounds;
    self.player.view.frame = frame;
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
    
    self.player.openSafariOnAdClick = YES;
    self.player.forceFullScreenOnLandscape = YES;
    self.player.forceLandscapeOnFullScreen = YES;
    //    self.player.enterFullScreen;
    
}

-(void) fncBackTapped:(UIButton*)sender
{
    if(self.navigationController){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }

    [self.player stop];
    [self.player exitFullScreen];
    [self.player.view setHidden:true];
//    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    
    
//    [self deinitJWPlayer];
    
    }

- (void)deinitJWPlayer
{
    if (self.player != nil) {
        [self.v removeFromSuperview];
        self.v = nil;
        [self.player.view removeFromSuperview];
        self.player = nil;
    }
}

- (void)onControlBarVisible:(BOOL)isVisible
{
    if(isVisible){
        [self.v setHidden:false];
        //        if(self.player.isInFullscreen)
        //        {
        //            [self.v setHidden:false];
        //        }else{
        //            [self.v setHidden:true];
        //            [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
        //        }
    }else{
        [self.v setHidden:true];
    }
}

- (void)onFullscreen:(BOOL)status
{
    if(status){
        [self.v setHidden:false];
    }else{
        [self.v setHidden:true];
        [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait) forKey:@"orientation"];
    }
}

@end
