//
//  FLDebugCellItemText.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/29.
//

#import "FLDebugCellItem.h"

@interface FLDebugCellItemText : FLDebugCellItem

@property (nonatomic, copy) NSString *descriptionText;

+ (instancetype)itemWithTitle:(NSString *)title descriptionText:(NSString *)descriptionText action:(dispatch_block_t)action;

@end
