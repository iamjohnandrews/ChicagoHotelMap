//
//  Hotel.h
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 11/28/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *starRating;
@property (strong, nonatomic) NSString *nightlyRate;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSString *thumbnailURL;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSNumber *reviewScore;
@end
