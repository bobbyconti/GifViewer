//
//  Giphy.m
//  GifViewer
//
//  Created by Bobby Conti on 3/30/19.
//  Copyright © 2019 Bobby Conti. All rights reserved.
//

#import "Giphy.h"

@implementation Giphy

// Defines path for still and animated gifs
+ (instancetype) giphyWithDictionary:(NSDictionary *) dictionary {
    Giphy *giphy = [[Giphy alloc] init];
    
    if ( giphy ) {
        giphy.animatedGifURL = [NSURL URLWithString:[dictionary valueForKeyPath:@"images.original.url"]];
        giphy.stillImageURL = [NSURL URLWithString:[dictionary valueForKeyPath:@"images.downsized_still.url"]];
    }
    
    return giphy;
}

@end
