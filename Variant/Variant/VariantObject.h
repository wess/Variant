//
//  VariantObject.h
//  Variant
//
//  Created by Wess Cope on 4/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VariantObject : NSObject
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) id          response;
@property (copy, nonatomic) NSNumber    *weight;

+ (instancetype)variantWithName:(NSString *)name response:(id)response;
+ (instancetype)variantWithName:(NSString *)name response:(id)response weight:(NSNumber *)weight;

@end
