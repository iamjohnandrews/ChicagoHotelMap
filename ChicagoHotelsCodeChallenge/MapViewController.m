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
#import "ModalHotelViewController.h"

@interface MapViewController ()
@property (strong, nonatomic) NSMutableArray *hotelPinsArray;
@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ListViewController *listVC = [[self.tabBarController viewControllers] firstObject];
    self.hotelInfo = listVC.hotelInfo;
    
    self.mapView.delegate = self;
    self.mapView.rotateEnabled = NO;
    
    NSArray *mapAnnotations = [self convertHotelObjectsIntoCoordinates:self.hotelInfo];
    [self.mapView addAnnotations:mapAnnotations];
    [self.mapView showAnnotations:mapAnnotations animated:YES];
}


- (NSArray *)convertHotelObjectsIntoCoordinates:(NSArray *)hotelObjects
{
    self.hotelPinsArray = [NSMutableArray array];
    
    for (Hotel *hotel in hotelObjects) {
        MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake((CLLocationDegrees)[hotel.latitude doubleValue], (CLLocationDegrees)[hotel.longitude doubleValue]);
        myAnnotation.title = hotel.name;

        [self.hotelPinsArray addObject:myAnnotation];
    }
    
    return (NSArray *)self.hotelPinsArray;
}

#pragma MapKit Delegate methods

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
    
    [self performSegueWithIdentifier:@"MapToHotelDetailsSegue" sender:view];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    //set up MKAnnotationView callout accessory view. wait until this method is called to download image to show. You dont want to fetch image for all the pins so doing it hear lazily loads image

    NSInteger index = [self.hotelPinsArray indexOfObject:view.annotation];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[MKAnnotationView class]]) {
        NSInteger index = [self.hotelPinsArray indexOfObject:((MKAnnotationView *)sender).annotation];
        Hotel *hotel = self.hotelInfo[index];
        
        if([segue.identifier isEqualToString:@"MapToHotelDetailsSegue"]) {
            ModalHotelViewController *modalHotelVC = (ModalHotelViewController *)segue.destinationViewController;
            modalHotelVC.selectedHotel = hotel;
        }
    }
}


@end
