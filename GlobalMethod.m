//
//  GlobalMethod.m
//  OZPostcode
//
//  Created by Matthew Lu on 31/03/2014.
//  Copyright (c) 2014 Matthew Lu. All rights reserved.
//

#import "GlobalMethod.h"

@implementation GlobalMethod


+ (BOOL)isIPHONE5 {
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    
    if(pixelHeight == 1136.0f)
    {
        NSLog(@"isIPHONE5");
        return TRUE;
    }
    NSLog(@"isIPHONE4");
    return FALSE;
}

@end
