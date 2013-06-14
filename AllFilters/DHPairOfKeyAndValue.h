//
//  DHPairOfKeyAndValue.h
//  AllFilters
//
//  Created by dho_everest on 6/11/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHPairOfKeyAndValue : NSObject
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *key;
@property SEL sel;
-(id) setKey:(NSString *)key setSEL:(SEL) sel setLabel:(NSString *)L;
@end
