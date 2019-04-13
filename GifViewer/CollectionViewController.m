//
//  CollectionViewController.m
//  GifViewer
//
//  Created by Bobby Conti on 3/28/19.
//  Copyright © 2019 Bobby Conti. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
#import "Giphy.h"
#import "DetailViewController.h"
#import "CollectionViewHeader.h"

@interface CollectionViewController ()

@property (strong, nonatomic) NSMutableArray *giphys;

@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"GifViewerCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshImages];
}

// Open a new session a fetch images from Giphy API
- (void) refreshImages {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"https://api.giphy.com/v1/gifs/trending?api_key=z9yuqZNSCiVLHK94BCozHjxBjwvGrXq3&rating=pg"];
    
    self.giphys = [NSMutableArray array];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // Parse JSON data into a dictionary
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        // Data array > images > downsized_still > url
        NSArray *dictionaries = [dictionary valueForKey:@"data"];
        
        for (NSDictionary *dict in dictionaries) {
            Giphy *giphy = [Giphy giphyWithDictionary:dict];
            [self.giphys addObject:giphy];
        }
        
        NSLog(@"%@", self.giphys);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    [task resume];
}


#pragma mark - Navigation

// Call up detail view when gif is selected
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *selectedIndexPath = [self.collectionView indexPathsForSelectedItems][0];
        
        Giphy *giphy = self.giphys[selectedIndexPath.row];
        DetailViewController *detailViewController = segue.destinationViewController;
        detailViewController.giphy = giphy;
    }
}


#pragma mark <UICollectionViewDataSource>

// Feed should only show one main section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// Feed should return number of gifs received in JSON session
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.giphys count];
}

// Configure each cell in the collection view
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    Giphy *giphy = [self.giphys objectAtIndex:indexPath.row];
    cell.giphy = giphy;
    
    return cell;
}

// Set cell size according to screen size to get 3 column grid on all devices
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 20) / 3;
    return CGSizeMake(width, width);
}


#pragma mark <UICollectionViewDelegate>

// Performs segue on the selected gif in the feed
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}

// Creates header view sets label text in collection view
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    CollectionViewHeader *headerView;
    if (kind == UICollectionElementKindSectionHeader){
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        headerView.headerLabel.text = @"Trending";
    }
    return headerView;
}

@end
