//
//  ModalHotelViewController.m
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 12/2/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import "ModalHotelViewController.h"

@interface ModalHotelViewController ()

@end

@implementation ModalHotelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.hotelImage.image = self.originalImage;
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


- (IBAction)dismissModalButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
