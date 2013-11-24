//
//  CalculatorBrain.h
//  Calculator
//
//  Created by uzero on 13-11-23.
//  Copyright (c) 2013年 net.uzero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject
- (void)push:(NSString *)numberOrOperate;
- (NSString *)pop;
- (NSString *)popTest;
- (void)cleanNumberStack;
- (unsigned)countOfBrain;
- (CalculatorBrain *)init;
- (NSString *)getItemInStackAtIndex:(int)index;
@end
