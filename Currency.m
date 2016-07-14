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
@synthesize formatter;

/*-(Currency*) initWithCoder:(NSCoder *)aDecoder
{
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
}

-(Currency*) initWithName:(NSString *)aName alphaCode:(NSString *)aCode Symbol:(NSString *)aSymbol decimalPlaces:(NSNumber *)places
{
}

-(NSString*) format:(NSNumber *)quantity
{
    
}*/

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@ %@ %@",self.name,self.alphaCode,self.symbol];
}


@end
