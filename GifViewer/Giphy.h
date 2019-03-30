//
//  Giphy.h
//  GifViewer
//
//  Created by Bobby Conti on 3/30/19.
//  Copyright © 2019 Bobby Conti. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Giphy : NSObject

@property (strong, nonatomic) NSURL *stillImageURL;
@property (strong, nonatomic) NSURL *animatedGifURL;

+ (instancetype) giphyWithDictionary:(NSDictionary *) dictionary;

@end

NS_ASSUME_NONNULL_END
