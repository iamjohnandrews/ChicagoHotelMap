//
//  ListTableViewCell.m
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 11/28/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.hotelImageView.clipsToBounds = YES;
    self.hotelImageView.contentMode = UIViewContentModeTopLeft;
    

}


@end
