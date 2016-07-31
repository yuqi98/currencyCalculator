//
//  ViewController.m
//  Currency
//
//  Created by Yuqi Zhang on 7/12/16.
//  Copyright © 2016 Yuqi Zhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController

@synthesize currencyList;


- (void)viewDidLoad {
    [super viewDidLoad];
    //self.numberOfComponents = 5;
    
    currencyList = [ExchangeRate allExchangeRates];
    
    self.inputType.delegate = self;
    self.outputType.delegate =self;
    self.inputType.dataSource=self;
    self.outputType.dataSource=self;
    [self.inputType selectRow:0 inComponent:0 animated:NO];
    [self.outputType selectRow:0 inComponent:0 animated:NO];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.inputValue resignFirstResponder];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView==self.inputType)
    {
        self.inputSymbol.text=((Currency*)[currencyList objectAtIndex:[self.inputType selectedRowInComponent:0]]).symbol;
    }
    if(pickerView==self.outputType)
    {
        self.outputSymbol.text=((Currency*)[currencyList objectAtIndex:[self.outputType selectedRowInComponent:0]]).symbol;
    }
    return ((Currency*) [currencyList objectAtIndex:row]).name;
}

- (IBAction)update:(id)sender {
}

- (IBAction)switchButton:(id)sender {
    [self.inputValue resignFirstResponder];
    
    NSString* tmp=self.inputValue.text;
    self.inputValue.text=self.outputValue.text;
    self.outputValue.text=tmp;
    
    NSInteger tmp2=[self.inputType selectedRowInComponent:0];
    [self.inputType selectRow:[self.outputType selectedRowInComponent:0] inComponent:0 animated:NO];
    [self.outputType selectRow:tmp2 inComponent:0 animated:NO];
    
    
}

- (IBAction)calculate:(id)sender {
    [self.outputValue resignFirstResponder];
    NSInteger input = [self.inputType selectedRowInComponent:0];
    NSInteger output = [self.outputType selectedRowInComponent:0];
    Currency* inputCurrency = [currencyList objectAtIndex:input];
    Currency* outputCurrency = [currencyList objectAtIndex:output];
    
    ExchangeRate* currentExchangeRate = [[ExchangeRate alloc]
                    initWithHome:inputCurrency
                    foreign:outputCurrency];
    
    [currentExchangeRate fetch];
    
    self.currentRate.text=[NSString stringWithFormat: @"%@", currentExchangeRate.rate];
    
    self.outputValue.text = [currentExchangeRate exchangeToForeign:@(self.inputValue.text.floatValue)];
    
}


@end
