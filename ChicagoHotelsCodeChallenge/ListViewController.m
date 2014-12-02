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

- (void)displaySpinnerAsDataLoadsFor:(UITableViewCell *)cell
{
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.hidesWhenStopped = YES;
    cell.accessoryView = self.spinner;
    [self.spinner startAnimating];
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
    
    if (!listCell.hotelImageView.image) {
        [self displaySpinnerAsDataLoadsFor:listCell];
    }
    [listCell.hotelImageView sd_setImageWithURL:[NSURL URLWithString:individualHotel.thumbnailURL]
                                           completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                               listCell.hotelImageView.image = image;
                                               [self.spinner stopAnimating];
                                           }];
    
    
    return listCell;
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
