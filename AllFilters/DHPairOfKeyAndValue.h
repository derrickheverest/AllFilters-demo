//
//  DHPairOfKeyAndValue.h
//  AllFilters
//
//  Created by dho_everest on 6/11/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHPairOfKeyAndValue : NSObject
@property (strong, nonatomic) NSString *key;
@property SEL sel;
-(void) setKey:(NSString *)key setSEL:(SEL) sel;
-(NSString *) getKey;
-(SEL) getSEL;
@end
