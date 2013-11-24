//
//  ViewController.m
//  Calculator
//
//  Created by uzero on 13-11-23.
//  Copyright (c) 2013年 net.uzero. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultDisplay;
@property (nonatomic) BOOL numberButtonWasPressing;
@property (nonatomic) BOOL operaterButtonWasPressed;
@property (weak, nonatomic) IBOutlet UILabel *displayCountOfStack;
@property (weak, nonatomic) IBOutlet UILabel *firstNumber;
@property (weak, nonatomic) IBOutlet UILabel *operater;
@property (weak, nonatomic) IBOutlet UILabel *lastNumber;
@property CalculatorBrain *numberStack;
- (IBAction)numberPressed:(UIButton *)sender;
- (IBAction)operatePressed:(UIButton *)sender;
- (IBAction)enterPressed:(UIButton *)sender;
- (IBAction)cleanPressed:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberStack = [[CalculatorBrain alloc] init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numberPressed:(UIButton *)sender
{
    NSString *display;
    NSString *lastNumber;
    if (self.operaterButtonWasPressed) {
        if (self.numberButtonWasPressing) {
            lastNumber = [[self.numberStack pop] stringByAppendingString:sender.currentTitle];
        } else {
            lastNumber = sender.currentTitle;
        }
       display = [self.resultDisplay.text stringByAppendingString:sender.currentTitle];
    } else {
        if (self.numberButtonWasPressing) {
            lastNumber = [[self.numberStack pop] stringByAppendingString:sender.currentTitle];
            display = [self.resultDisplay.text stringByAppendingString:sender.currentTitle];
        } else {
            [self.numberStack cleanNumberStack];
            lastNumber = sender.currentTitle;
            display = sender.currentTitle;
        }
    }
    [self.numberStack push:lastNumber];
    self.resultDisplay.text = display;
    self.numberButtonWasPressing = YES;
    self.operaterButtonWasPressed = NO;
    [self buttonWasPressed];
}

- (double) calculateResult
{
    double lastNumber = [[self.numberStack pop] doubleValue];
    NSString *operate = [self.numberStack pop];
    double firstNumber = [[self.numberStack pop] doubleValue];
    double result;
    if ([operate isEqualToString:@"+"]) {
        result = firstNumber + lastNumber;
    } else if ([operate isEqualToString:@"-"]) {
        result = firstNumber - lastNumber;
    } else if ([operate isEqualToString:@"*"]) {
        result = firstNumber * lastNumber;
    } else {
        result = firstNumber / lastNumber;
    }
    
    return result;
}

- (IBAction)operatePressed:(UIButton *)sender {
    if (!self.operaterButtonWasPressed) {
        if ([self.numberStack countOfBrain] == 3) {
            double result = [self calculateResult];
            [self.numberStack cleanNumberStack];
            [self.numberStack push:[NSString stringWithFormat:@"%g", result]];
            [self.numberStack push:sender.currentTitle];
            self.resultDisplay.text = [NSString stringWithFormat:@"%g%@", result, sender.currentTitle];
        } else {
            [self.numberStack push:sender.currentTitle];
            self.resultDisplay.text = [self.resultDisplay.text stringByAppendingString:sender.currentTitle];
        }
        self.operaterButtonWasPressed = YES;
    } else {
        if (self.numberButtonWasPressing) {
            [self.numberStack pop];
            NSString *firstNumber = [self.numberStack popTest];
            [self.numberStack push:sender.currentTitle];
            self.resultDisplay.text = [NSString stringWithFormat:@"%@%@", firstNumber, sender.currentTitle];
            self.operaterButtonWasPressed = YES;
        }
    }
    self.numberButtonWasPressing = NO;
    [self buttonWasPressed];
}

- (IBAction)enterPressed:(UIButton *)sender {
    if ([self.numberStack countOfBrain] == 3) {
        double result = [self calculateResult];
        [self.numberStack cleanNumberStack];
        [self.numberStack push:[NSString stringWithFormat:@"%g", result]];
        self.resultDisplay.text = [NSString stringWithFormat:@"%g", result];
        self.operaterButtonWasPressed = NO;
        self.numberButtonWasPressing = NO;
    }
        [self buttonWasPressed];
}

- (IBAction)cleanPressed:(UIButton *)sender {
    [self.numberStack cleanNumberStack];
    self.resultDisplay.text = @"0";
    self.numberButtonWasPressing = NO;
    self.operaterButtonWasPressed = NO;
    [self buttonWasPressed];
}

- (IBAction)buttonWasPressed {
    self.displayCountOfStack.text = [NSString stringWithFormat:@"%d", [self.numberStack countOfBrain]];
    if ([self.numberStack countOfBrain] > 0) {
        self.firstNumber.text = [self.numberStack getItemInStackAtIndex:0];
    } else {
        self.firstNumber.text = @"";
        self.operater.text = @"";
        self.lastNumber.text = @"";
    }
    if ([self.numberStack countOfBrain] > 1) {
        self.operater.text = [self.numberStack getItemInStackAtIndex:1];
    } else {
        self.operater.text = @"";
        self.lastNumber.text = @"";
    }
    if ([self.numberStack countOfBrain] > 2) {
        self.lastNumber.text = [self.numberStack getItemInStackAtIndex:2];
    } else {
        self.lastNumber.text = @"";
    }
}
@end
