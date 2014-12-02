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
#import "UIImageView+WebCache.h"

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
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 400, 400);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKAnnotationView *aView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"hotel"];
    if (!aView) {
        aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"hotel"];
        aView.canShowCallout = YES;
        
        UIImageView *hotelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 46.0f, 46.0f)];
        aView.leftCalloutAccessoryView = hotelImageView;
        
        // Add a detail disclosure button to the callout.
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.rightCalloutAccessoryView = rightButton;
    }
    
    aView.annotation = annotation;
    
    return aView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //gets called when button in accessory view is tapped... so  you dont need target/action. This is where you segue
    
    [self performSegueWithIdentifier:@"placeholder" sender:view];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //set up MKAnnotationView callout accessory view. wait until this method is called to download image to show. You dont want to fetch image for all the pins so doing it hear lazily loads image

    
    NSInteger index;
    
    if ([view.annotation isKindOfClass:[MKAnnotationView class]]) {
        index = [self.hotelInfo indexOfObject:view.annotation];
    }
    Hotel *hotel = self.hotelInfo[index];
    
    
    if ([view.leftCalloutAccessoryView isKindOfClass:[UIImageView class]]) {
        UIImageView *hotelImageView = (UIImageView *)view.leftCalloutAccessoryView;
        [hotelImageView sd_setImageWithURL:[NSURL URLWithString:hotel.thumbnailURL]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     hotelImageView.image = image;
                                 }];
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
