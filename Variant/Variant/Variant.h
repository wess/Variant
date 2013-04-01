//
//  Variant.h
//  Variant
//
//  Created by Wess Cope on 3/31/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VariantObject.h"

typedef id(^VariantResponseBlock)();

@interface Variant : NSObject
@property (readonly, nonatomic) NSString *name;

+ (instancetype)variantTestWithName:(NSString *)name;
+ (id)variantTestWithA:(id)A B:(id)B;
- (instancetype)initWithName:(NSString *)name;
- (void)addResponse:(id)response forVariant:(NSString *)variant;
- (void)addResponse:(id)response forVariant:(NSString *)variant withWeight:(NSNumber *)weight;
- (void)addVariants:(NSArray *)variants;
- (id)execute;
@end
