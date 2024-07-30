//
//  FLDebugCellItemSwitch.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "FLDebugCellItemSwitch.h"
#import "FLDebugTableSwitchCell.h"

@interface FLDebugCellItemSwitch ()

@end

@implementation FLDebugCellItemSwitch

+ (instancetype)itemWithTitle:(NSString *)title isOn:(BOOL)isOn switchBlock:(FLDebugCellSwitchBlock)switchBlock
{
    FLDebugCellItemSwitch *item = [[FLDebugCellItemSwitch alloc] init];
    item.title = title;
    item.isOn = isOn;
    item.switchBlock = switchBlock;
    return item;
}

+ (Class)bindCellClass
{
    return FLDebugTableSwitchCell.class;
}

+ (NSString *)bindCellReuseIdentifier
{
    return NSStringFromClass([self bindCellClass]);
}

+ (CGFloat)cellHeight
{
    return 40;
}


@end
