//
//  CollectionViewCell.h
//  GifViewer
//
//  Created by Bobby Conti on 3/28/19.
//  Copyright © 2019 Bobby Conti. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Giphy;

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) Giphy *giphy;

@end

NS_ASSUME_NONNULL_END
