//
//  FLDebugTableBaseCell.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import <UIKit/UIKit.h>
#import "FLDebugCellItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLDebugTableBaseCell : UITableViewCell

//- (void)renderCellWithData:(NSDictionary *)dic;
- (void)renderCellWithItem:(FLDebugCellItem *)item;

@end

NS_ASSUME_NONNULL_END
