//
//  SettingsViewController.m
//  WPKN-Live
//
//  Created by Patrick Serrano on 12/2/13.
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


#import "SettingsViewController.h"
#import "PlayerViewController.h"

#define WPKN_ORANGE [UIColor colorWithRed:1.000 green:0.373 blue:0.298 alpha:1.000]

#define LOW_QUALITY [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http:71.172.68.27:8000/wpknlow.mp3"] options:nil]]
#define MED_QUALITY [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http:71.172.68.27:8000/wpknmed.mp3"] options:nil]]
#define HIGH_QUALITY [AVPlayerItem playerItemWithAsset:[AVURLAsset URLAssetWithURL:[NSURL URLWithString:@"http:71.172.68.27:8000/wpknhigh.mp3"] options:nil]]

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma -
#pragma mark - IBActions

- (IBAction)contackWPKN:(id)sender {
    NSString *subject = [NSString stringWithFormat:@"WPKN is my favorite station!"];
    NSArray *addresses = [NSArray arrayWithObject:@"gm@wpkn.org"];
    NSString *messageBody = [NSString stringWithFormat:@"You guys rock!"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:subject];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:addresses];

    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry!"
                                                        message:@"Sorry but this feature requires a e-mail account to be set up on your device"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles: nil];
        [alert show];
        NSLog(@"No Mail Account");
        
    } else {
        [self.tabBarController presentViewController:mc
                                            animated:YES
                                          completion:NULL];
    }
}

- (IBAction)developerContact:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://patrickserrano.com"]];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)facebookButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/groups/wpknradio/?fref=ts"]];
}

- (IBAction)twitterButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/WPKNradio"]];
}

- (IBAction)flickrButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.flickr.com/search/?q=wpkn"]];
}

- (IBAction)youtubeButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/user/wpknradio"]];
}

#pragma -
#pragma mark - Helper Methods

- (IBAction)selectQuality:(id)sender {
    PlayerViewController *pvc = [self.tabBarController.viewControllers objectAtIndex:0];
    if (self.qualitySegmentControl.selectedSegmentIndex == 0) {
        [pvc stop];
        [pvc.audioPlayer replaceCurrentItemWithPlayerItem:LOW_QUALITY];
        [pvc play];
    } else if (self.qualitySegmentControl.selectedSegmentIndex == 1) {
        [pvc stop];
        [pvc.audioPlayer replaceCurrentItemWithPlayerItem:MED_QUALITY];
        [pvc play];
    } else if (self.qualitySegmentControl.selectedSegmentIndex == 2) {
        [pvc stop];
        [pvc.audioPlayer replaceCurrentItemWithPlayerItem:HIGH_QUALITY];
        [pvc play];
    }
}
@end
