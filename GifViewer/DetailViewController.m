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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( self.giphy ) {
        NSURLRequest *request = [NSURLRequest requestWithURL:self.giphy.animatedGifURL];
        
        [self.webView loadRequest:request];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
