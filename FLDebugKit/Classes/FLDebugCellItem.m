//
//  FLDebugCellItem.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugCellItem.h"
#import "FLDebugTableBaseCell.h"

NSString * const kFLDebugCellTapArrayKey = @"kFLDebugCellTapArrayKey";
NSUInteger const kMaxTapArrayCount = 3;

@interface FLDebugCellItem ()

@property (nonatomic, copy) dispatch_block_t action;

@end

@implementation FLDebugCellItem

+ (instancetype)itemWithTitle:(NSString *)title action:(dispatch_block_t)action
{
    FLDebugCellItem *item = [[FLDebugCellItem alloc] init];
    item.title = title;
    item.action = action;
    return item;
}

- (void)doAction
{
    NSString *itemKeepKey = [self tapKeepKey];
    NSMutableArray *tapArray = [[[NSUserDefaults standardUserDefaults] objectForKey:kFLDebugCellTapArrayKey] mutableCopy];
    if (!tapArray) {
        tapArray = [[NSMutableArray alloc] init];
    }
    if (![tapArray containsObject:itemKeepKey]) {
        if (tapArray.count >= kMaxTapArrayCount) {
            [tapArray removeObjectAtIndex:0];
        }
        if (tapArray.count < kMaxTapArrayCount) {
            [tapArray addObject:itemKeepKey];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:tapArray forKey:kFLDebugCellTapArrayKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (self.action) {
        self.action();
    }
}

- (BOOL)hasAction
{
    if (self.action) {
        return YES;
    }
    return NO;
}

- (NSString *)tapKeepKey
{
    return [NSString stringWithFormat:@"%@%@", NSStringFromClass(self.class), self.title];
}

+ (Class)bindCellClass
{
    return FLDebugTableBaseCell.class;
}

+ (NSString *)bindCellReuseIdentifier
{
    return NSStringFromClass([self bindCellClass]);
}

+ (CGFloat)cellHeight
{
    return 40;
}

- (id)copyWithZone:(NSZone __unused *)zone {
    FLDebugCellItem *item = [[FLDebugCellItem alloc] init];
    item.title = self.title;
    item.action = self.action;
    return item;
}
@end
