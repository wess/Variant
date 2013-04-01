//
//  VariantObject.h
//  Variant
//
//  Created by Wess Cope on 4/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 `VariantObject` is class that provides a clean and easy way to create test variants.
 */

@interface VariantObject : NSObject
/// ----------------------------------------
/// @name Object container for test items.
/// ----------------------------------------


/**
 Name of Variant.
 */
@property (copy, nonatomic) NSString    *name;

/**
 Response object of Variant
 
 @note Response object can be any valid Objective-C object type, including blocks. 
 If a block is given, the return on that block is the resulting variants response.
 */
@property (copy, nonatomic) id<NSCopying>          response;

/**
 Weight of a variant when testing.
 
 @note Weight can be a value between 1 and 100, which represents the percentage of 
 chances for the object to be selected.
 */
@property (strong, nonatomic) NSNumber    *weight;

/**
 Shortcut method for creating an instance of VariableObject
 
 @param name        Name of Variant.
 
 @param response    Return object if test selects variant.
 
 @return            Instance of VariantObject.
 */
+ (instancetype)variantWithName:(NSString *)name response:(id)response;

/**
 Shortcut method for creating an instance of VariableObject
 
 @param name        Name of Variant.
 
 @param response    Return object if test selects variant.
 
 @param weight      Weight of variant when testing.
 
 @see weight
 
 @return            Instance of VariantObject.
 */
+ (instancetype)variantWithName:(NSString *)name response:(id)response weight:(NSNumber *)weight;

@end
