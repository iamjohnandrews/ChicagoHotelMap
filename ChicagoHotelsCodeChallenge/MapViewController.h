//
//  MapViewController.h
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 11/28/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *hotelInfo;
@property (strong, nonatomic) NSArray *hotelimages;


@end
