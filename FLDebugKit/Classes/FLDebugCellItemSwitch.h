//
//  FLDebugCellItemSwitch.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "FLDebugCellItem.h"

typedef void (^FLDebugCellSwitchBlock) (BOOL isOn);

@interface FLDebugCellItemSwitch : FLDebugCellItem

@property (nonatomic, assign) BOOL isOn;

@property (nonatomic, copy) FLDebugCellSwitchBlock switchBlock;

+ (instancetype)itemWithTitle:(NSString *)title isOn:(BOOL)isOn switchBlock:(FLDebugCellSwitchBlock)switchBlock;

@end


