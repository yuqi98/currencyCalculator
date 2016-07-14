//
//  ExchangeRate.h
//  Currency
//
//  Created by Yuqi Zhang on 7/13/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface ExchangeRate : NSObject <NSCoding>

@property (strong, nonatomic) Currency* home;
@property (strong, nonatomic) Currency* foreign;
@property (assign, nonatomic) NSNumber* rate;
//assign  not*  copy things out
//float->NSNumber   cuz float cannot be encode
@property (strong, nonatomic) NSDate* expiresOn;

@property (strong) NSMutableDictionary *completionHandlerDictionary;
@property (strong) NSURLSessionConfiguration *ephemeralConfigObject;

-(NSURL*) exchangeRateURL;
+(NSArray*) allExchangeRates;


//strong, assign must synthesize

-(bool) updateRate;


//-(NSString*) exchangeToHome: (NSNumber*) value;  //be simple  don't need this one

//-(NSString*) exchangeToForeign: (NSNumber*) value;

//-(void) reverse;
//-(NSString*) name;

//-(NSString*) description;   //to debug    include all information

-(ExchangeRate*) initWithHome:(Currency*) aHome
                      foreign:(Currency*) aForeign;

-(ExchangeRate*) initWithDate:(NSDate*) aDate;

-(void) fetch;


@end
