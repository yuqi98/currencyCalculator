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

-(ExchangeRate*) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self){
        self.expiresOn = [aDecoder decodeObjectOfClass: [ExchangeRate class] forKey: @"date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.expiresOn forKey:@"date"];
}

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

+(NSArray*) allExchangeRates
{
    NSMutableArray* allRates = [[NSMutableArray alloc] init];
    [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"GBP"]];
    [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"JPY"]];
    [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"MXN"]];
    [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"EUR"]];
    [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: @"USD" foreignCurrency: @"CAD"]];
    //NSLog(@"%@",allRates);
    return (NSArray*)allRates;
}


/*-(NSString*) exchangeToForeign:(NSNumber *)value
{
    
}

-(void) reverse
{
    
}

-(NSString*) name
{
    
}

-(NSString*) description
{
    return[NSString stringWithFormat:@"%@%@",self.home,self.foreign];
}*/



-(void) fetch
{
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: self.ephemeralConfigObject delegate: nil delegateQueue: mainQueue];
    for(ExchangeRate* i in [ExchangeRate allExchangeRates]){
        NSLog(@"dispatching %@", [i description]);
        NSURLSessionTask* task = [delegateFreeSession dataTaskWithURL: [i exchangeRateURL]
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        NSLog(@"Got response %@ with error %@.\n", response, error);
                                                        id obj = [NSJSONSerialization JSONObjectWithData: data
                                                                                                 options: 0
                                                                                                   error: nil];
                                                        if( [obj isKindOfClass: [NSDictionary class]] ){
                                                            NSDictionary *dict = (NSDictionary*)obj;
                                                            NSLog(@"%@", [dict description]);
                                                            NSDictionary* results = [dict objectForKey: @"results"];
                                                            NSDictionary* rate=[results objectForKey: @"rate"];
                                                            self.rate=[]
                                                        }else{
                                                            NSLog(@"Not a dictionary.");
                                                            exit(1);
                                                        }
                                                        /*NSLog(@"DATA:\n%@\nEND DATA\n",
                                                         [[NSString alloc] initWithData: data
                                                         encoding: NSUTF8StringEncoding]);*/
                                                    }];
        [task resume];
    }
}



@end
