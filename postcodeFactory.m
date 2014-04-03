//
//  postcodeFactory.m
//  OZPostcode
//
//  Created by Matthew Lu on 31/03/2014.
//  Copyright (c) 2014 Matthew Lu. All rights reserved.
//

#import "postcodeFactory.h"

#import "AppDelegate.h"

@implementation postcodeFactory

+(void)createAUPostcode
{
    
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"aus_clean" ofType: @"csv"];
    NSString *csvContent = [self getCSVContent:pathToFile];
     NSArray *csvData = [csvContent componentsSeparatedByString:@"\r"];
    
    //NSLog(@"%@",csvData);
    
   // NSLog(@"%d",csvData.count);
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext];
    
    for (int i = 0; i< csvData.count; i++) {
        NSString * singleLine = csvData[i];
        NSArray *lineData = [singleLine componentsSeparatedByString:@","];
        
        Postcode *postcode =[NSEntityDescription insertNewObjectForEntityForName:@"Postcode" inManagedObjectContext:context];
        postcode.postcodeID = [NSNumber numberWithInt:i];
        postcode.postcode = lineData[0];
        postcode.suburb = lineData[1];
        postcode.state = lineData[2];
        postcode.city = lineData[3];
        postcode.lat = [NSNumber numberWithDouble:[lineData[4] doubleValue]];
        postcode.lon = [NSNumber numberWithDouble:[lineData[5] doubleValue]];
        postcode.country = kAU;
    }
    
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"could not save: %@",[error localizedDescription]);
    }
}



+(NSArray *)getAUpostcode
{
    //   NSMutableArray *issuerArray = [[NSMutableArray alloc]init];
    NSError *error;
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Postcode" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    //sorting by pid
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"postcodeID" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"lon != 0"];
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    
    
    return fetchedObjects;

}



+(void)createNZPostcode
{
    NSString *pathToFile = [[NSBundle mainBundle] pathForResource:@"nz_clean" ofType: @"csv"];
    NSString *csvContent = [self getCSVContent:pathToFile];
    NSArray *csvData = [csvContent componentsSeparatedByString:@"\r"];
    

    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext];
    // 167283 is the total count for AU postcode
    
    for (int i = 0; i< csvData.count; i++) {
        NSString * singleLine = csvData[i];
        NSArray *lineData = [singleLine componentsSeparatedByString:@","];
        
      //  for (int j= 167283; j< 167283 +lineData.count; j++) {
     //   Linton Military Camp,4820,175.584791,-40.404779
            Postcode *postcode =[NSEntityDescription insertNewObjectForEntityForName:@"Postcode" inManagedObjectContext:context];
            postcode.postcodeID = [NSNumber numberWithInt:i+167283];
            postcode.postcode = lineData[1];
            postcode.suburb = lineData[0];

            postcode.lat = [NSNumber numberWithDouble:[lineData[3] doubleValue]];
            postcode.lon = [NSNumber numberWithDouble:[lineData[2] doubleValue]];
            postcode.country = kNZ;
            
      //  }
    }
    
    NSError *error;
    if(![context save:&error])
    {
        NSLog(@"could not save: %@",[error localizedDescription]);
    }

}


+(NSString*)getCSVContent:(NSString*)csvName
{
    return [NSString stringWithContentsOfFile:csvName encoding:NSUTF8StringEncoding error:nil];
}



+(NSArray*)getPostcodeByPostcode:(NSString*)postcode and:(NSString*)country
{
    
    //   NSMutableArray *issuerArray = [[NSMutableArray alloc]init];
    NSError *error;
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Postcode" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    //sorting by pid
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"postcodeID" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate;
    
    if ([country isEqualToString:kAU] || [country isEqualToString:kNZ]) {
         predicate = [NSPredicate predicateWithFormat:@"lon != 0 and country = %@ and postcode like[cd] %@  or suburb like[cd] %@",country,postcode,postcode];
    }
    else
    {
        predicate = [NSPredicate predicateWithFormat:@"(lon != 0) AND (postcode beginswith[cd] %@) or suburb beginswith[cd] %@",postcode,postcode];
    }
    
    [fetchRequest setPredicate:predicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    return fetchedObjects;

    
}

+(void)clearPostCoredata
{
    NSError *error;
    
    NSManagedObjectContext *context = [(AppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Postcode" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    for (Postcode *postcode in fetchedObjects) {
        [context deleteObject:postcode];
    }
    [context save:&error];
}
@end
