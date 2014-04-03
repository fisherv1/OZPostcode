//
//  MapViewController.m
//  OZPostcode
//
//  Created by Matthew Lu on 1/04/2014.
//  Copyright (c) 2014 Matthew Lu. All rights reserved.
//

#import "MapViewController.h"
#import "Postcode.h"
#import "Place.h"
#import "GlobalMethod.h"

@interface MapViewController ()
{
    CLLocationCoordinate2D theCoordinate;
    __weak IBOutlet UIView *mapTypeSegment;
}
@property (weak, nonatomic) IBOutlet MKMapView *map;

@end

@implementation MapViewController
@synthesize map,postcode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)mapTypeChanged:(UISegmentedControl*)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            map.mapType = MKMapTypeStandard;
            sender.selectedSegmentIndex = 0;
            break;
        case 1:
            map.mapType = MKMapTypeSatellite;
             sender.selectedSegmentIndex = 1;
            break;
        case 2:
            map.mapType = MKMapTypeHybrid;
             sender.selectedSegmentIndex = 2;
            break;
        default:
            break;
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  map.delegate = self;

}


-(void)viewWillAppear:(BOOL)animated
{
    [map setMapType:MKMapTypeStandard];
    //set latitude and longitude
    theCoordinate.latitude = [postcode.lat floatValue];
    theCoordinate.longitude = [postcode.lon floatValue];
    
    //set display range
    MKCoordinateSpan theSpan;
    theSpan.latitudeDelta = 0.1;
    theSpan.longitudeDelta = 0.1;
    
    //set map cneter and rangae
    MKCoordinateRegion theRegion;
    theRegion.center = theCoordinate;
    theRegion.span = theSpan;
    
    [map setRegion:theRegion];
    
    //set Annotation
    Place *anonation = [[Place  alloc]init];
    anonation.title = postcode.suburb;
    anonation.subtitle = [NSString stringWithFormat:@"%@ - %@", postcode.country, postcode.postcode];
    anonation.coordinate = theCoordinate;
    
    [map addAnnotation:anonation];
    

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    pan.delegate = self;
    [pan setMinimumNumberOfTouches:1];
    [pan setMaximumNumberOfTouches:1];
    
    [map setUserInteractionEnabled:YES];
    [map addGestureRecognizer:pan];
    
    if (![GlobalMethod isIPHONE5]) {
        mapTypeSegment.frame = CGRectMake(0, 367, 320, 49);
        mapTypeSegment.hidden = false;
    }

    
}


-(void)handlePan:(UIGestureRecognizer*)gestureRecognizer
{
  
    
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateEnded:
        {
            mapTypeSegment.hidden = false;
            self.navigationController.navigationBar.hidden = false;
            break;
        }
        case  UIGestureRecognizerStateBegan:
        {
            mapTypeSegment.hidden = YES;
           self.navigationController.navigationBar.hidden= YES;
            break;
        }
        
        default:
            break;
    }
    //mapTypeSegment.hidden = YES;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
