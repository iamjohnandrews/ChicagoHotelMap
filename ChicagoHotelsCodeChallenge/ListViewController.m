//
//  ListViewController.m
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 11/28/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import "ListViewController.h"
#import "ListTableViewCell.h"
#import "Hotel.h"
#import "UIImageView+WebCache.h"

@interface ListViewController ()
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) NSMutableArray *hotelImagesArray;
@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.hotelListTableView.delegate = self;
    self.hotelListTableView.dataSource = self;
    self.hotelInfo = [self getHotelData];
    self.hotelImagesArray = [NSMutableArray array];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSArray *)getHotelData
{
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"hotels" ofType:@"json"];
    NSDictionary *rawData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath]
                                                            options:kNilOptions
                                                              error:nil];
    
    NSArray *convertedHotelInfo = [[NSArray alloc] initWithArray:[self parseJSON:rawData]];
    
    return convertedHotelInfo;
}

- (NSArray *)parseJSON:(NSDictionary *)jsonDict
{
    NSMutableArray *hotelObjectsArray = [NSMutableArray array];
    NSArray *hotelsDict = [jsonDict objectForKey:@"hotels"];
    
    for (NSDictionary *hotelDetails in hotelsDict) {
        Hotel *hotel = [[Hotel alloc] init];
        hotel.name = [hotelDetails objectForKey:@"name"];
        hotel.starRating = [hotelDetails objectForKey:@"star_rating"];
        hotel.nightlyRate = [hotelDetails objectForKey:@"nightly_rate"];
        hotel.longitude = [hotelDetails objectForKey:@"longitude"];
        hotel.latitude = [hotelDetails objectForKey:@"latitude"];
        hotel.thumbnailURL = [hotelDetails objectForKey:@"thumbnail"];
        hotel.streetAddress = [hotelDetails objectForKey:@"street_address"];
        hotel.reviewScore = [hotelDetails objectForKey:@"review_score"];
        
        [hotelObjectsArray addObject:hotel];
    }
    return hotelObjectsArray;
}

#pragma mark - TableView Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.hotelInfo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    
    Hotel *individualHotel = self.hotelInfo[indexPath.row];
    listCell.hotelNameLabel.text = individualHotel.name;
    
    UIActivityIndicatorView *spinner;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    if (![manager diskImageExistsForURL:[NSURL URLWithString:individualHotel.thumbnailURL]]) {
        spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.hidesWhenStopped = YES;
        listCell.accessoryView = spinner;
        [spinner startAnimating];
    }
    [listCell.hotelImageView sd_setImageWithURL:[NSURL URLWithString:individualHotel.thumbnailURL]
                                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                               listCell.hotelImageView.image = [self imageWithImage:image];
                                               [spinner stopAnimating];
                                           }];
    
    
    return listCell;
}

- (UIImage *)imageWithImage:(UIImage *)image
{
    CGSize newSize = CGSizeMake(80.0f, 60.0f);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
