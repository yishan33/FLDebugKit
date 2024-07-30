//
//  FLDebugTableVC.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import <UIKit/UIKit.h>
#import "FLDebugManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLDebugTableVC : UITableViewController

- (instancetype)initWithManager:(FLDebugManager *)manager;

@end

NS_ASSUME_NONNULL_END
