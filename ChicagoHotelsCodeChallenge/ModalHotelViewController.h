//
//  ModalHotelViewController.h
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 12/2/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel.h"

@interface ModalHotelViewController : UIViewController
@property (strong, nonatomic) Hotel *selectedHotel;
@property (weak, nonatomic) IBOutlet UIImageView *hotelImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *starRating;
@property (weak, nonatomic) IBOutlet UILabel *nightlyRate;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *reviewScore;
@property (weak, nonatomic) IBOutlet UIButton *dismissModalButton;
- (IBAction)dismissModalButtonPressed:(id)sender;

@end
