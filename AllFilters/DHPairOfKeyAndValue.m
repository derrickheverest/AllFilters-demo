//
//  DHPairOfKeyAndValue.m
//  AllFilters
//
//  Created by dho_everest on 6/11/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import "DHPairOfKeyAndValue.h"

@implementation DHPairOfKeyAndValue
-(void) setKey:(NSString *)k setSEL:(SEL) s{
    self->_key = k;
    self->_sel = s;
}
-(NSString *) getKey{
    if (self->_key) {
        return self->_key;
    }
    return nil;
}
-(SEL) getSEL{
    return self->_sel;
}
@end
