//
//  FLDebugSectionItemDevice.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugSectionItemDevice.h"

@implementation FLDebugSectionItemDevice

+ (void)load
{
    [self registerWithSection:kFLDebugSection_Device block:^NSArray *{
        NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
        NSString *buildInterval = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleVersion"];
        FLDebugCellItemText *versionItem = [FLDebugCellItemText itemWithTitle:@"App版本号" descriptionText:appVersion action:nil];
        FLDebugCellItemText *buildIntervalItem = [FLDebugCellItemText itemWithTitle:@"构建号" descriptionText:buildInterval action:nil];
        return @[versionItem, buildIntervalItem];
    }];
}

@end
