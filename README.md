# Variant
Variant is a simple library for creating multivariate testing for your Objective-C projects.

## Setup
To use Variant, just include the Variant project in your project and link against libVariant.a.

## Example Usage
Variant has a simple approach to creating and executing tests.	Just import <Variant/Variant.h> define your test and execute the instance when needed.

```objectivec
#import <Variant/Variant.h>

// Quick test
    NSString *abTest = (NSString *)[Variant variantTestWithA:^{
        return @"Hello";
    } B:^{
        return @"World";
    }];
    
    NSLog(@"TEST: %@", abTest);
    
    // Build test:
    Variant *test = [Variant newVariantTest];
    [test addResponse:@“Hello world” forVariant:@“A”];
    [test addResponse:@“This is a test” forVariant:@“B”];
    [test addResponse:^{
    	return “This is a block string response”;
    } forVariant:@“C”];
    
    NSString *response = (NSString *)[test execute];
    
    NSLog(@“Response: %@“, response);
    
```

## Developer info
* [Github](http://www.github.com/wess)
* [@WessCope](http://www.twitter.com/wesscope)

## License
Read LICENSE file for more info.
