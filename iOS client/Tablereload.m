//
//  Tablereload.m
//  ValetAttendant
//
//  Created by techbasics on 4/21/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import "Tablereload.h"

@implementation Tablereload

+ (id)itemWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:(NSString *)title];
}

- (id)initWithTitle:(NSString *)title
{
    if ((self = [super init]))
    {
        _title = title;
      
    }
    
    return self;
}



@end
