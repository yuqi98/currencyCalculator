//
//  ExchangeRate.m
//  Currency
//
//  Created by Yuqi Zhang on 7/13/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import "ExchangeRate.h"

@implementation ExchangeRate

@synthesize home;
@synthesize foreign;
@synthesize rate;
@synthesize expiresOn;
@synthesize completionHandlerDictionary;
@synthesize ephemeralConfigObject;



-(ExchangeRate*) initWithDate:(NSDate*)aDate
{
    self=[super init];
    if(self)
    {
        self.expiresOn=aDate;
    }
    return self;
}


-(ExchangeRate*) initWithHome:(Currency *)aHome foreign:(Currency *)aForeign
{
    self=[super init];
    if(self)
    {
        self.home=aHome;
        self.foreign=aForeign;
    }
    return self;
}

-(bool) updateRate
{
    return YES;
}

-(NSURL*) exchangeRateURL
{
    NSString* urlString = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22%@%@%%22)&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=",self.home.alphaCode,self.foreign.alphaCode];
    return [NSURL URLWithString:urlString];
}

-(ExchangeRate*) initWithHomeCurrency: (NSString*) aHomeCurrency
                      foreignCurrency: (NSString*) aForeignCurrency
{
    self = [super init];
    if(self){
        self.foreign.alphaCode = aForeignCurrency;
        self.home.alphaCode = aHomeCurrency;
        self.completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
        self.ephemeralConfigObject = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    }
    return self;
}

+(NSMutableArray*) allExchangeRates
{
    NSMutableArray* allRates = [[NSMutableArray alloc] init];
    [allRates addObject: [[Currency alloc] initWithName:@"US Dollar" alphaCode:@"USD" Symbol:@"$" decimalPlaces:@(2)]];
    [allRates addObject: [[Currency alloc] initWithName:@"Japanese Yen" alphaCode:@"JPY" Symbol:@"¥" decimalPlaces:@(0)]];
    [allRates addObject: [[Currency alloc] initWithName:@"Chinese Yuan" alphaCode:@"CNY" Symbol:@"¥" decimalPlaces:@(2)]];
    [allRates addObject: [[Currency alloc] initWithName:@"Euro" alphaCode:@"EUR" Symbol:@"€" decimalPlaces:@(2)]];
    [allRates addObject: [[Currency alloc] initWithName:@"Singapore dollar" alphaCode:@"SGD" Symbol:@"S$" decimalPlaces:@(2)]];
    //NSLog(@"%@",allRates);
    return allRates;
}



-(void) fetch
{
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: self.ephemeralConfigObject delegate: nil delegateQueue: mainQueue];
    NSLog(@"dispatching %@", [self description]);
    NSURLSessionTask* task = [delegateFreeSession dataTaskWithURL: [self exchangeRateURL]
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    NSLog(@"Got response %@ with error %@.\n", response, error);
                                                    id obj = [NSJSONSerialization JSONObjectWithData: data
                                                                                             options: 0
                                                                                               error: nil];
                                                    if( [obj isKindOfClass: [NSDictionary class]] ){
                                                        NSDictionary *dict = (NSDictionary*)obj;
                                                        NSLog(@"%@", [dict description]);
                                                        NSDictionary* query=[dict objectForKey: @"query"];
                                                        NSDictionary* results = [query objectForKey: @"results"];
                                                        NSDictionary* aRate=[results objectForKey: @"rate"];
                                                        
                                                        
                                                        NSString* value = (NSString*)[aRate objectForKey:@"Rate"];
                                                        
                                                        self.rate = @(value.floatValue);
                                                        
                                                //NSLog(@"%f",self.rate.floatValue);
                                                        
                                                    }else{
                                                        NSLog(@"Not a dictionary.");
                                                        exit(1);
                                                    }
                                                    /*NSLog(@"DATA:\n%@\nEND DATA\n",
                                                     [[NSString alloc] initWithData: data
                                                     encoding: NSUTF8StringEncoding]);*/
                                                }];
    [task resume];
    
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    

}

-(NSString*) exchangeToForeign:(NSNumber *)value
{
    NSLog(@"%@",self.rate);
    return ([NSString stringWithFormat:@"%0.2f",value.floatValue*self.rate.floatValue]);
}

-(void) reverse
{
    self.rate=@(1.0/(self.rate).floatValue);
    
    Currency* tmp=self.home;
    self.home=self.foreign;
    self.foreign=tmp;
}

-(NSString*) name
{
    return [home.alphaCode stringByAppendingString:foreign.alphaCode];
}

-(NSString*) description
{
    return[NSString stringWithFormat:@"%@%@",self.home,self.foreign];
}






@end
