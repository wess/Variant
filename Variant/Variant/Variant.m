//
//  Variant.m
//  Variant
//
//  Created by Wess Cope on 3/31/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "Variant.h"

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
    
    [variants enumerateObjectsUsingBlock:^(VariantObject *variant, NSUInteger idx, BOOL *stop) {
        NSInteger weight = [variant.weight integerValue];

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
        VariantObject *object   = [variants objectAtIndex:i];
        NSInteger weight        = [object.weight integerValue];

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

+ (id)variantTestWithA:(id)A B:(id)B
{
    NSString *name  = @"ABTest";
    Variant *test   = [Variant variantTestWithName:name];

    [test addResponse:A forVariant:@"A"];
    [test addResponse:B forVariant:@"B"];
    
    return [test execute];
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

- (void)addResponse:(id)response forVariant:(NSString *)variant;
{
    [self.variants addObject:[VariantObject variantWithName:variant response:response]];
}

- (void)addResponse:(id)response forVariant:(NSString *)variant withWeight:(NSNumber *)weight
{
    
    [self.variants addObject:[VariantObject variantWithName:variant response:response weight:weight]];
}

- (void)addVariants:(NSArray *)variants
{
    [variants enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSAssert([obj isKindOfClass:[VariantObject class]], @"Variant requires all variant options to be VariantObjects");
        [self.variants addObject:obj];
    }];
}

- (id)execute
{
    NSInteger index = selectIndexForVariants(self.variants);
    id obj = self.variants[index][@"response"];
    
    if([obj isKindOfClass:NSClassFromString(@"NSBlock")])
    {
        VariantResponseBlock block = [obj copy];
        return block();
    }
    
    
    return obj;
}

@end


