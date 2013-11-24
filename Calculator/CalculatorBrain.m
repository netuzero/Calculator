//
//  CalculatorBrain.m
//  Calculator
//
//  Created by uzero on 13-11-23.
//  Copyright (c) 2013年 net.uzero. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (strong, nonatomic) NSMutableArray *brain;
@end

@implementation CalculatorBrain
- (void)push:(NSString *)numberOrOperate
{
    [self.brain addObject:numberOrOperate];
}

- (CalculatorBrain *)init
{
    self = [super init];
    self.brain = [[NSMutableArray alloc] init];
    return self;
}

- (NSString *)pop
{
    NSString *numberOrOperate = [self.brain lastObject];
    [self.brain removeLastObject];
    return numberOrOperate;
}

- (NSString *)popTest
{
    NSString *numberOrOperate = [self.brain lastObject];
    return numberOrOperate;
}

- (void)cleanNumberStack
{
    [self.brain removeAllObjects];
}

- (unsigned)countOfBrain
{
    return (unsigned)[self.brain count];
}

/*for debug*/
- (NSString *)getItemInStackAtIndex:(int)index
{
    return [self.brain objectAtIndex:index];
}
@end
