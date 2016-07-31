//
//  ViewController.h
//  Currency
//
//  Created by Yuqi Zhang on 7/12/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"
#import "ExchangeRate.h"

@interface ViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *inputValue;

@property (weak, nonatomic) IBOutlet UILabel *outputValue;

@property (weak, nonatomic) IBOutlet UIPickerView *inputType;
@property (weak, nonatomic) IBOutlet UIPickerView *outputType;
@property (weak, nonatomic) IBOutlet UILabel *currentRate;

@property(nonatomic, readonly) NSInteger numberOfComponents;

@property (weak, nonatomic) IBOutlet UILabel *outputSymbol;
@property(strong,nonatomic) NSMutableArray* currencyList;
@property (weak, nonatomic) IBOutlet UILabel *inputSymbol;

- (IBAction)switchButton:(id)sender;

- (IBAction)calculate:(id)sender;
- (IBAction)update:(id)sender;


@end

