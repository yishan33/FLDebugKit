//
//  FLDebugCellItemText.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/29.
//

#import "FLDebugCellItemText.h"
#import "FLDebugTableTextCell.h"

@interface FLDebugCellItemText ()

@property (nonatomic, copy) dispatch_block_t action;

@end

@implementation FLDebugCellItemText

+ (instancetype)itemWithTitle:(NSString *)title descriptionText:(NSString *)descriptionText action:(dispatch_block_t)action
{
    FLDebugCellItemText *item = [[FLDebugCellItemText alloc] init];
    item.title = title;
    item.descriptionText = descriptionText;
    item.action = action;
    return item;
}

+ (Class)bindCellClass
{
    return FLDebugTableTextCell.class;
}

- (id)copyWithZone:(NSZone __unused *)zone {
    FLDebugCellItemText *item = [[FLDebugCellItemText alloc] init];
    item.title = self.title;
    item.descriptionText = self.descriptionText;
    item.action = self.action;
    return item;
}

@end
