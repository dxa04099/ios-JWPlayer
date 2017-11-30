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

@end

@implementation JWPLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self createPopulatePlayer];
    [self.view addSubview:self.player.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)createPopulatePlayer
{
    JWConfig *config = [JWConfig new];
    config.file = @"https://origin-supersoccer-b-01.vos360.video/Content/HLS/VOD/daf82114-e53e-4e52-9701-e61457f525ca/68fb97dc-8666-635a-5742-c1ccce4088de/index.m3u8";
    config.controls = YES;
    
    self.player = [[JWPlayerController alloc] initWithConfig:config];
    
    self.btnBack = [UIButton new];
    self.btnBack = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnBack setTitle:@" < " forState:UIControlStateNormal];
    [self.btnBack sizeToFit];
    self.btnBack.backgroundColor = [UIColor clearColor];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateFocused];
    [self.btnBack addTarget:self
                action:@selector(fncBackTapped:)
      forControlEvents:UIControlEventTouchUpInside];
    [self.player.view addSubview:self.btnBack];
    
    
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

@end
