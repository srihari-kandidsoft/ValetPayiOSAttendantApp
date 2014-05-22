//
//  Tablereload.h
//  ValetAttendant
//
//  Created by techbasics on 4/21/14.
//  Copyright (c) 2014 techbasics. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tablereload : NSObject
+ (id)itemWithTitle:(NSString *)title ;
- (id)initWithTitle:(NSString *)title ;

@property (nonatomic, copy) NSString *title;
@end
