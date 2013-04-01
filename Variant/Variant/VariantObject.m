//
//  VariantObject.m
//  Variant
//
//  Created by Wess Cope on 4/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import "VariantObject.h"

@implementation VariantObject
+ (instancetype)variantWithName:(NSString *)name response:(id)response
{
    return [[self class] variantWithName:name response:response weight:nil];
}

+ (instancetype)variantWithName:(NSString *)name response:(id)response weight:(NSNumber *)weight
{
    VariantObject *object   = [[VariantObject alloc] init];
    object.name             = name;
    object.response         = response;
    object.weight           = weight;
    
    return object;
}

@end
