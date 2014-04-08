//
//  PlayerViewController.h
//  WPKN-Live
//
//  Created by Patrick Serrano on 6/30/13.
//  Copyright (c) 2013-2014 Patrick Serrano.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013-2014 Patrick Serrano.
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

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "SettingsViewController.h"

@interface PlayerViewController : UIViewController <AVAudioPlayerDelegate>

// Properties
@property (strong, nonatomic) AVAsset *avAsset;
@property (strong, nonatomic) AVPlayerItem *playerItem;
@property (strong, nonatomic) AVPlayer *audioPlayer;
@property (strong, nonatomic) NSURL *streamURL;
@property (strong, nonatomic) NSString *streamURLAsAString;

// IBActions
- (IBAction)audioPlay:(id)sender;
- (IBAction)audioStop:(id)sender;
- (IBAction)reloadStream:(id)sender;
- (IBAction)selectQuality:(id)sender;

// IBOutlets
@property (weak, nonatomic) IBOutlet UIImageView *levelsView;
@property (weak, nonatomic) IBOutlet UILabel *listeningLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *controlLabel;

//iPad IBOutlets
@property (weak, nonatomic) IBOutlet UISegmentedControl *qualitySegmentControl;

// Helper Methods
- (void)reload;
- (void)stop;
- (void)play;
- (void)togglePlayPause;
- (BOOL)isPlaying;

@end