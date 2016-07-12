//
//  ViewController.m
//  flappyBird
//
//  Created by Ray Sabbineni on 9/2/15.
//  Copyright (c) 2015 Ray Sabbineni. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

     NSInteger score = [[NSUserDefaults standardUserDefaults]integerForKey:@"HighScoreSaved"];
    self.highScore.text = [ NSString stringWithFormat:@"%li", score];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
