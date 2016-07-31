//
//  Currency.h
//  Currency
//
//  Created by Yuqi Zhang on 7/13/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* alphaCode;
@property (strong, nonatomic) NSString* symbol;
@property (strong, nonatomic) NSNumber* decimalPlaces;

-(Currency*) initWithName:(NSString*) aName
                alphaCode:(NSString*) aCode
                   Symbol:(NSString*) aSymbol
            decimalPlaces:(NSNumber*) places;

-(NSString*) format:(NSNumber*) quantity;

-(NSString*) description;


@end
