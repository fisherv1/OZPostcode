//
//  Place.h
//  Mini Redeem
//
//  Created by Permissioncorp on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface Place : NSObject <MKAnnotation> {

    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    NSString *shopid;
    UIImage *img1;
    NSString *shopIndex;
}
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
@property (nonatomic,copy) NSString *shopid;
@property (nonatomic,copy) UIImage *img1;
@property (nonatomic,copy) NSString *shopIndex;

@end
