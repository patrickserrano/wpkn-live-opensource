//
//  SettingsViewController.h
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

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate>

#pragma -
#pragma mark - Properties
@property (strong, nonatomic) NSURL *streamURL;

#pragma -
#pragma mark - IBOutlets
@property (weak, nonatomic) IBOutlet UISegmentedControl *qualitySegmentControl;

#pragma -
#pragma mark - IBActions
- (IBAction)developerContact:(id)sender;
- (IBAction)contackWPKN:(id)sender;
- (IBAction)facebookButton:(id)sender;
- (IBAction)twitterButton:(id)sender;
- (IBAction)flickrButton:(id)sender;
- (IBAction)youtubeButton:(id)sender;
- (IBAction)selectQuality:(id)sender;

#pragma -
#pragma mark - Helper Methods


@end