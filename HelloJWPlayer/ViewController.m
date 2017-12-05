//
//  ViewController.m
//  HelloJWPlayer
//
//  Created by subhan on 11/30/17.
//  Copyright © 2017 subhan. All rights reserved.
//

#import "ViewController.h"
#import "JWPLayerViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toJWPlayer:(UIButton *)sender {
    
    JWPLayerViewController * jwPlayer = [[JWPLayerViewController alloc] init];
    jwPlayer.streamUrl = @"https://origin-supersoccer-b-01.vos360.video/Content/HLS/VOD/daf82114-e53e-4e52-9701-e61457f525ca/68fb97dc-8666-635a-5742-c1ccce4088de/index.m3u8";
    [self presentViewController:jwPlayer animated:FALSE completion:nil];
    
}


@end


