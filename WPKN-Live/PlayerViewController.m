//
//  PlayerViewController.m
//  WPKN-Live
//
//  Created by Patrick Serrano on 6/30/13.
//  Copyright (c) 2013-2014 Patrick Serrano.
//
//  The MIT License (MIT)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.


#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>

#define LOW_QUALITY [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http:71.172.68.27:8000/wpknlow.mp3"] options:nil]]
#define MED_QUALITY [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http:71.172.68.27:8000/wpknmed.mp3"] options:nil]]
#define HIGH_QUALITY [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http:71.172.68.27:8000/wpknhigh.mp3"] options:nil]]

#define WPKN_ORANGE [UIColor colorWithRed:1.000 green:0.373 blue:0.298 alpha:1.000]


@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad
{
    self.streamURL = [NSURL URLWithString:@"http://71.172.68.27:8000/wpknmed.mp3"];
    self.avAsset = [AVURLAsset URLAssetWithURL:self.streamURL options:nil];
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.avAsset];
    self.audioPlayer = [AVPlayer playerWithPlayerItem:self.playerItem];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    self.stopButton.alpha = 0;
    [self.stopButton setHidden:YES];
    self.levelsView.animationImages = [NSArray arrayWithObjects:
                                       [UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"],
                                       [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"],
                                       [UIImage imageNamed:@"5"], [UIImage imageNamed:@"6"],
                                       [UIImage imageNamed:@"7"], [UIImage imageNamed:@"8"],
                                       [UIImage imageNamed:@"9"], [UIImage imageNamed:@"10"],
                                       [UIImage imageNamed:@"11"], [UIImage imageNamed:@"12"],
                                       [UIImage imageNamed:@"13"], [UIImage imageNamed:@"14"],
                                       [UIImage imageNamed:@"15"], [UIImage imageNamed:@"16"],
                                       [UIImage imageNamed:@"17"], [UIImage imageNamed:@"18"],
                                       [UIImage imageNamed:@"19"], [UIImage imageNamed:@"20"],
                                       [UIImage imageNamed:@"21"], [UIImage imageNamed:@"22"],
                                       [UIImage imageNamed:@"23"], [UIImage imageNamed:@"24"], nil];
    self.levelsView.animationDuration = 1.0;
    
    self.tabBarController.tabBar.tintColor = WPKN_ORANGE;
    
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    if (![self isPlaying]) {
        [self stop];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
}

#pragma mark - iPhone IBActions
- (IBAction)audioPlay:(id)sender
{
    [self play];
}

- (IBAction)audioStop:(id)sender
{
    [self stop];
}

- (IBAction)reloadStream:(id)sender
{
    [self reload];
}

#pragma mark iPad IBActions
- (IBAction)selectQuality:(id)sender
{
    if (self.qualitySegmentControl.selectedSegmentIndex == 0) {
        [self.audioPlayer replaceCurrentItemWithPlayerItem:LOW_QUALITY];
    } else if (self.qualitySegmentControl.selectedSegmentIndex == 1) {
        [self.audioPlayer replaceCurrentItemWithPlayerItem:MED_QUALITY];
    } else if (self.qualitySegmentControl.selectedSegmentIndex == 2) {
        [self.audioPlayer replaceCurrentItemWithPlayerItem:HIGH_QUALITY];
    }
}

#pragma mark - Delegate Methods
-(BOOL)canBecomeFirstResponder
{
    return YES;
}


- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPlay) {
            [self play];
        } else if (event.subtype == UIEventSubtypeRemoteControlPause) {
            [self stop];
        } else if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self togglePlayPause];
        }
    }
}

#pragma mark - Helper Methods
- (void)stop
{
    if ([self isPlaying]) {
        [self.audioPlayer pause];
        [self.levelsView stopAnimating];
        self.listeningLabel.text = @"Listen Live";
        [UIView animateWithDuration:0.5f animations:^{
            self.stopButton.alpha = 0;
            [self.stopButton setHidden:YES];
            [self.playButton setHidden:NO];
            self.playButton.alpha = 1.0;
            self.controlLabel.text = @"Play";
        }];
    }
}

- (void)play
{
    if (![self isPlaying]) {
        [self.audioPlayer play];
        [self.levelsView startAnimating];
        self.listeningLabel.text = @"Listening Live";
        [self.playButton setHidden:YES];
        [self.stopButton setHidden:NO];
        [UIView animateWithDuration:0.5f animations:^{
            self.playButton. alpha = 0;
            [self.playButton setHidden:YES];
            [self.stopButton setHidden:NO];
            self.stopButton.alpha = 1.0;
            self.controlLabel.text = @"Stop";
        }];

    }
}

- (void)togglePlayPause
{
    if (![self isPlaying]) {
        [self play];
    } else if ([self isPlaying]) {
        [self stop];
    }
}

- (void)reload
{
    [self stop];
    [self play];
}

- (BOOL)isPlaying
{
    if (self.audioPlayer.currentItem && self.audioPlayer.rate != 0)
    {
        return YES;
    }
    return NO;
}

- (void)childViewController:(SettingsViewController *)settingsViewController setSegmentIndex:(int)segmentIndex
{
    NSLog(@"%i",segmentIndex);
    if (segmentIndex == 0) {
        NSLog(@"%i",segmentIndex);
        [self stop];
        [self.audioPlayer replaceCurrentItemWithPlayerItem:LOW_QUALITY];
        [self play];
    } else if (segmentIndex == 1) {
        [self.audioPlayer replaceCurrentItemWithPlayerItem:MED_QUALITY];
        NSLog(@"passed 1");
    } else if (segmentIndex == 2) {
        [self.audioPlayer replaceCurrentItemWithPlayerItem:HIGH_QUALITY];
        NSLog(@"passed 2");
    }
}

@end
