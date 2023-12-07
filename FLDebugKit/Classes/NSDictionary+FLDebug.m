//
//  NSMutableDictionary+FLDebug.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "NSDictionary+FLDebug.h"

@interface NSDictSortItem : NSObject
@property (nonatomic, strong) id itemKey;
@property (nonatomic, strong) id itemValue;
@end
@implementation NSDictSortItem
@end

@implementation NSDictionary (FLDebug)

- (NSArray *)sortedKeysByKeyWithResult:(NSComparisonResult)result
{
    NSArray *sortedResult = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[NSString class]]) {
            NSString *str1 = (NSString *)obj1;
            NSString *str2 = (NSString *)obj2;
            return [str1 compare:str2];
        }
        if ([obj1 isKindOfClass:[NSNumber class]]) {
            NSNumber *num1 = (NSNumber *)obj1;
            NSNumber *num2 = (NSNumber *)obj2;
            return [num1 integerValue] > [num2 integerValue];
        }
        return obj1 > obj2;
    }];
    
    if (result == NSOrderedDescending) {
        return [[sortedResult reverseObjectEnumerator] allObjects];
    }
    return sortedResult;
}

- (NSArray *)sortedKeysByValueWithResult:(NSComparisonResult)result
{
    NSArray *sortedResult = [[self allValues] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        if ([obj1 isKindOfClass:[NSString class]]) {
            NSString *str1 = (NSString *)obj1;
            NSString *str2 = (NSString *)obj2;
            return [str1 compare:str2];
        }
        if ([obj1 isKindOfClass:[NSNumber class]]) {
            NSNumber *num1 = (NSNumber *)obj1;
            NSNumber *num2 = (NSNumber *)obj2;
            return [num1 integerValue] > [num2 integerValue];
        }
        return obj1 > obj2;
    }];
    
    if (result == NSOrderedDescending) {
        return [[sortedResult reverseObjectEnumerator] allObjects];
    }
    
    NSArray *allKeys = [self allKeys];
    
    
    return sortedResult;
}


@end
