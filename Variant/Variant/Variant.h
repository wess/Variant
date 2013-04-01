//
//  Variant.h
//  Variant
//
//  Created by Wess Cope on 3/31/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VariantObject.h"

/**
 `Variant` is class that provides simplified multivariants testing.
 */

typedef id(^VariantResponseBlock)();

@interface Variant : NSObject

///---------------------------------------------------------------
/// @name Class for creating and executing multivariants test.
///---------------------------------------------------------------

/**
 Creates a new Variant test instance;
 
 @return instancetype New object instantiated from Variant class.
 */
+ (instancetype)newVariantTest;

/**
 Quick test that yields a response when called.
 
 @param A   Return item if test result is first item, A.
 
 @param B   Return item if test result is last item, B.
 
 @return Resulting item from the executed test.
 */
+ (id)variantTestWithA:(id)A B:(id)B;

/**
 Adds a variant to a test instance.
 
 @param response Item to resond if variant is selected.
 
 @param variant  Name of variant.
 
 */
- (void)addResponse:(id)response forVariant:(NSString *)variant;


/**
 Adds a variant, with weight, to a test instance.
 
 @param response    Item to resond if variant is selected.
 
 @param variant     Name of variant.
 
 @param weight      Number between 1 and 100 for probility of selection.
 */
- (void)addResponse:(id)response forVariant:(NSString *)variant withWeight:(NSNumber *)weight;

/**
 Adds an array of VariantObjects to test instance.
 
 @param variants Array of Variant objects to use with test.
 */
- (void)addVariants:(NSArray *)variants;

/**
 Executes test and returns response of variant result.
 
 @return Response object, or return value of block, of selected variant.
 */
- (id)execute;
@end
