//
//  WebViewController.m
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

#import "WebViewController.h"

#define WPKN_ORANGE [UIColor colorWithRed:1.000 green:0.373 blue:0.298 alpha:1.000]
#define WPKN_BG_COLOR [UIColor colorWithRed:0.886 green:0.859 blue:0.835 alpha:1.000]

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad
{
    // Start Animations and set deleage
    [self.spinner startAnimating];
    [self.webView setDelegate:self];
    self.shareApplication = [UIApplication sharedApplication];
    [self.webView setHidden:YES];
    [self.webNavToolBar setHidden:YES];
    [self loadWPKN];
    
    [super viewDidLoad];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self.webView reload];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (!self.webView.isLoading) {
        [UIView animateWithDuration:1.0f animations:^{
            self.spinner.alpha = 0;
            self.logoView.alpha = 0;
            [self.backgroundView setHidden:YES];
            [self.webView setHidden:NO];
            [self.webNavToolBar setHidden:NO];
            [self.spinner setHidden:YES];
            [self.logoView setHidden:YES];
            [self.spinner stopAnimating];
            self.shareApplication.networkActivityIndicatorVisible = NO;
        }];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"Error : %@",error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Timed Out"
                                                    message:@"It looks like we're having some trouble processing your request, please try again in a few minutes."
                                                   delegate:nil
                                          cancelButtonTitle:@"Dismiss"
                                          otherButtonTitles: nil];
    [alert show];
}

- (void)loadWPKN
{
    NSURL *url = [NSURL URLWithString:@"http://wpkn.org"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLCacheStorageAllowed
                                         timeoutInterval:300.0f];
    [self.webView loadRequest:request];
    self.shareApplication.networkActivityIndicatorVisible = YES;
}

- (IBAction)webBack:(id)sender
{
    [self.webView goBack];
}

- (IBAction)webForward:(id)sender
{
    [self.webView goForward];
}

- (IBAction)webReload:(id)sender
{
    [self.webView reload];
    [self.spinner setHidden:NO];
}
@end
