//
//  postcodeFactory.h
//  OZPostcode
//
//  Created by Matthew Lu on 31/03/2014.
//  Copyright (c) 2014 Matthew Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Postcode.h"
@interface postcodeFactory : NSObject


+(void)createAUPostcode;
+(NSArray *)getAUpostcode;

+(void)createNZPostcode;

+(NSArray*)getPostcodeByPostcode:(NSString*)postcode and:(NSString*)country;
+(void)clearPostCoredata;
@end
