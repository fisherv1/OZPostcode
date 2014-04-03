//
//  Postcode.h
//  OZPostcode
//
//  Created by Matthew Lu on 31/03/2014.
//  Copyright (c) 2014 Matthew Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Postcode : NSManagedObject

@property (nonatomic, retain) NSNumber * postcodeID;
@property (nonatomic, retain) NSString * postcode;
@property (nonatomic, retain) NSString * suburb;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSNumber * lon;
@property (nonatomic, retain) NSString * country;

@end
