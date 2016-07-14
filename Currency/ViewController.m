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

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.numberOfComponents = 5;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)update:(id)sender {
}

- (IBAction)switchButton:(id)sender {
}

- (IBAction)calculate:(id)sender {
    Currency* currentValue;
    ExchangeRate* currentExchangeRate;
    NSNumber* value;
    NSString* a=[NSString stringWithString:self.inputValue.text];
    value=@(a.floatValue);
    
    NSString* realvalue=[currentValue format: value];
    self.outputValue.text=[currentExchangeRate exchangeToForeign:[currentValue quantity].floatvalue];
}


@end
