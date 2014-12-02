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
//    self.hotelImageView.clipsToBounds = YES;
//    self.hotelImageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    [self setupGradient];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupGradient
{
    CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
    bottomGradientLayer.frame = self.hotelImageView.layer.bounds;
    
    bottomGradientLayer.colors = @[(id)[[UIColor clearColor] CGColor],
                                   (id)[[UIColor clearColor] CGColor],
                                   (id)[[UIColor colorWithWhite:0.0 alpha:1.0] CGColor]];
    bottomGradientLayer.locations = @[@0.45, @0.8, @1.0];
    [self.hotelImageView.layer addSublayer:bottomGradientLayer];
}

@end
