//
//  FLDebugSectionItemMemory.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/30.
//

#import "FLDebugSectionItemMemory.h"
#import "UIViewController+FLDebug.h"
#import "FLDebugAlertUtils.h"

@implementation FLDebugSectionItemMemory

+ (void)load
{
    [self registerWithType:FLDebugSectionType_Data identifier:@"Yingshou" block:^NSArray *{
        FLDebugCellItemText *clearCacheItem = [FLDebugCellItemText itemWithTitle:@"清理缓存1" descriptionText:@"35.2MB" action:^{
            NSLog(@"清理缓存");
        }];
        
        FLDebugCellItemText *userDefaultItem = [FLDebugCellItemText itemWithTitle:@"UserDefault1" descriptionText:@"查看详情" action:^{
            UIViewController *vc = [[UIViewController alloc] init];
            [[UIViewController topViewController].navigationController pushViewController:vc animated:YES];
        }];
        
        FLDebugCellItemSwitch *showMsgSwitchItem = [FLDebugCellItemSwitch itemWithTitle:@"显示信息开关" isOn:YES switchBlock:^(BOOL isOn) {
            NSLog(@"当前值:%@", @(isOn));
        }];
        
        FLDebugCellItemText *showAlertItem = [FLDebugCellItemText itemWithTitle:@"显示告警信息" descriptionText:@"告警值" action:^{
            [FLDebugAlertUtils handleAlertActionWithVC:[UIViewController topViewController] text:@"环境已切换完毕,请重启App" confirmBlock:nil cancelBlock:nil];
        }];

        return @[clearCacheItem, userDefaultItem, showMsgSwitchItem, showAlertItem];
    }];
}

@end
