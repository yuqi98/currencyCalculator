//
//  Currency.m
//  Currency
//
//  Created by Yuqi Zhang on 7/13/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import "Currency.h"

@implementation Currency

@synthesize name;
@synthesize alphaCode;
@synthesize symbol;
@synthesize decimalPlaces;


-(Currency*) initWithName:(NSString *)aName alphaCode:(NSString *)aCode Symbol:(NSString *)aSymbol decimalPlaces:(NSNumber *)places
{
    self=[super init];
    if(self)
    {
        self.name=aName;
        self.symbol=aSymbol;
        self.alphaCode=aCode;
        self.decimalPlaces=places;
    }
    return self;
}

-(NSString*) format:(NSNumber *)quantity
{
    return [NSString stringWithFormat:@"%@",quantity];
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ %@ %@",self.name,self.alphaCode,self.symbol];
}


@end
