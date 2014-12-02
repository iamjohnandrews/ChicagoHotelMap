//
//  MapViewController.m
//  ChicagoHotelsCodeChallenge
//
//  Created by John Andrews on 11/28/14.
//  Copyright (c) 2014 John Andrews. All rights reserved.
//

#import "MapViewController.h"
#import "ListViewController.h"
#import "Hotel.h"

@interface MapViewController ()
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ListViewController *listVC = [[self.tabBarController viewControllers] firstObject];
    self.hotelInfo = listVC.hotelInfo;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.showsUserLocation = YES;
    
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    [self.mapView addAnnotations:[self convertHotelObjectsIntoCoordinates:self.hotelInfo]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.showsUserLocation = NO;
}

- (NSArray *)convertHotelObjectsIntoCoordinates:(NSArray *)hotelObjects
{
    NSMutableArray *hotelPinsArray = [NSMutableArray array];
    
    for (Hotel *hotel in hotelObjects) {
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake((CLLocationDegrees)[hotel.latitude doubleValue], (CLLocationDegrees)[hotel.longitude doubleValue]);
        myAnnotation.title = hotel.name;
        
        [hotelPinsArray addObject:myAnnotation];
    }
    
    return (NSArray *)hotelPinsArray;
}

#pragma MapKit Delegate methods
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 500, 500);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"hotel"];
    
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"hotel"];
    }
    
    aView.annotation = annotation;
    
    return aView;
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
