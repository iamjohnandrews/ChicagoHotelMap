//
//  ModalHotelViewController.m
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 12/2/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import "ModalHotelViewController.h"
#import "UIImageView+WebCache.h"

@interface ModalHotelViewController ()

@end

@implementation ModalHotelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self getImage];
    [self setupUI];
}

- (void)setupUI
{
    self.name.text = self.selectedHotel.name;
    self.starRating.text = self.selectedHotel.starRating;
    self.nightlyRate.text = [NSString stringWithFormat:@"$%@", self.selectedHotel.nightlyRate];
    self.reviewScore.text = [self.selectedHotel.reviewScore stringValue];
    self.address.text = self.selectedHotel.streetAddress;
    
    self.dismissModalButton.backgroundColor = [UIColor lightGrayColor];
    self.dismissModalButton.layer.cornerRadius = 8;
    self.dismissModalButton.layer.borderWidth = 1;
    self.dismissModalButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.dismissModalButton.clipsToBounds = YES;
    self.dismissModalButton.titleLabel.textColor = [UIColor blueColor];
}

- (void)getImage
{
    [self.hotelImage sd_setImageWithURL:[NSURL URLWithString:self.selectedHotel.thumbnailURL]
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  self.hotelImage.image = image;
                              }];
}


- (IBAction)dismissModalButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
