//
//  MapViewController.h
//  OZPostcode
//
//  Created by Matthew Lu on 1/04/2014.
//  Copyright (c) 2014 Matthew Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@class Postcode;

@interface MapViewController : UIViewController<CLLocationManagerDelegate,MKAnnotation,UIGestureRecognizerDelegate>

@property(strong,nonatomic) Postcode *postcode;
@end
