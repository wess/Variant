//
//  Variant.h
//  Variant
//
//  Created by Wess Cope on 3/31/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Variant : NSObject
@property (readonly, nonatomic) NSString *name;

+ (instancetype)variantTestWithName:(NSString *)name;
+ (void)variantTestWithA:(void(^)())A B:(void(^)())B;

- (instancetype)initWithName:(NSString *)name;
- (void)addResponse:(void(^)())response forVariant:(NSString *)variant;
- (void)addResponse:(void(^)())response forVariant:(NSString *)variant withWeight:(NSNumber *)weight;
- (void)removeVariant:(NSString *)variant;
- (id)execute;
@end
