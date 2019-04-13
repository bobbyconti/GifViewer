//
//  DetailViewController.m
//  GifViewer
//
//  Created by Bobby Conti on 3/30/19.
//  Copyright © 2019 Bobby Conti. All rights reserved.
//

#import "DetailViewController.h"
#import "Giphy.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

// Loads detail view with animated gif
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( self.giphy ) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.giphy.animatedGifURL];
        
        [self.webView loadRequest:request];
    }
    
    [self setupGestures];
}

#pragma mark - Gestures

// Setup tap and swipe right gestures
- (void)setupGestures {
    UITapGestureRecognizer *dismiss = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    
    dismiss.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:dismiss];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDismiss)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipe];
}

// Tap to dismiss with animation
- (void)dismiss {
    
    [UIView animateWithDuration:0.75 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.01, 0.01);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

// Swipe right to dismiss with animation
- (void)swipeToDismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(400, 0);
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
