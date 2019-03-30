//
//  DetailViewController.h
//  GifViewer
//
//  Created by Bobby Conti on 3/30/19.
//  Copyright © 2019 Bobby Conti. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Giphy;

@interface DetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) Giphy *giphy;

@end

NS_ASSUME_NONNULL_END
