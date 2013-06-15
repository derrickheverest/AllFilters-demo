//
//  DHPairOfKeyAndValue.m
//  AllFilters
//
//  Created by dho_everest on 6/11/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import "DHPairOfKeyAndValue.h"

@implementation DHPairOfKeyAndValue
-(id) setKey:(NSString *)k setSEL:(SEL) s setLabel:(NSString *)L{
    self->_key = k;
    self->_sel = s;
    self->_label = L;
    return self;
}
-(id) setKey:(NSString *)k setLabel:(NSString *)L setBlock:(void (^)())sblk{
    self->SavedBlock = sblk;
    return [self setKey:k setSEL:nil setLabel:L];
}
@end
