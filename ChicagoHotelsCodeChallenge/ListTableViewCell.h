//
//  ListTableViewCell.h
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 11/28/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *hotelImageView;
@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;

@end
