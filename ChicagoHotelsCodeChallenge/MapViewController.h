//
//  MapViewController.h
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 11/28/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *hotelInfo;

@end
