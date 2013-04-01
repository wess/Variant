//
//  Variant.m
//  Variant
//
//  Created by Wess Cope on 3/31/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "Variant.h"

/*
 Variant *v = [Variant variantTestWithName:@"shit"];
 [v addResponse:^{} forVariant:@"A"];
 [v addResponse:^{} forVariant:@"B"];
 [v addResponse:^{} forVariant:@"C"];
 [v addResponse:^{} forVariant:@"D"];
 
 
 [v execute];
 
 */

@interface Variant()
@property (strong, nonatomic) NSMutableArray *variants;
@end

@implementation Variant
@synthesize name = _name;

static NSInteger selectIndexForVariants(NSArray *variants)
{
    NSInteger count = variants.count;
    
    __block NSInteger weightlessCount   = count;
    __block NSInteger weightLeft        = 100;
    
    [variants enumerateObjectsUsingBlock:^(NSDictionary *variant, NSUInteger idx, BOOL *stop) {
        NSInteger weight = [variant[@"weight"] integerValue];

        if(weight > 0)
            weightlessCount--;

        weightLeft -= weight;
    }];
    
    if(weightLeft <= -1)
        @throw [NSException exceptionWithName:@"Variant Value Exception" reason:@"Weight of variants cannot be more that 100%" userInfo:nil];

    if(weightlessCount == 0 && weightLeft > 0)
        @throw [NSException exceptionWithName:@"Variant Value Exception" reason:@"Weight of variants must add up to 100" userInfo:nil];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        srandomdev();
    });
    
    float rand          = ((float)random() / INT_MAX);
    float currentVal    = 0.0f;
    float fillWeight    = (weightlessCount < 1)? 0 : (weightLeft / (float)weightlessCount);
    
    for (int i = 0; i < count; i++)
    {
        NSDictionary *v = [variants objectAtIndex:i];
        NSInteger weight = [[v valueForKey:@"weight"] integerValue];

        currentVal += (weight == 0? (fillWeight / 100.0f) : (weight / 100.0f) );
        
        if (currentVal > rand)
            return i;
    }
    
    return --count;
}

+ (instancetype)variantTestWithName:(NSString *)name
{
    return [[Variant alloc] initWithName:name];
}

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self)
    {
        self.variants = [[NSMutableArray alloc] init];
        
        _name = [name copy];
    }
    return self;
}

- (void)addResponse:(void(^)())response forVariant:(NSString *)variant
{

    [self.variants addObject:@{@"name": variant, @"response": [response copy]}];

}

- (void)addResponse:(void(^)())response forVariant:(NSString *)variant withWeight:(NSNumber *)weight
{
    [self.variants addObject:@{@"name": variant, @"response": [response copy], @"weight": weight}];
}

- (void)removeVariant:(NSString *)variant
{
    
}

+ (void)variantTestWithA:(void(^)())A B:(void(^)())B
{
    
}

- (id)execute
{
    for(NSInteger i = 100; i > 0; i--)
    {
        NSInteger index = selectIndexForVariants(self.variants);
        NSLog(@"I: %d // Index: %d", i, index);
    }
    
    return nil;
}

@end


