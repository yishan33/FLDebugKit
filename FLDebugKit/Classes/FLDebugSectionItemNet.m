//
//  FLDebugSectionItemNet.m
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#import "FLDebugSectionItemNet.h"

@implementation FLDebugSectionItemNet

+ (void)load
{
    [self registerWithSection:kFLDebugSection_Net block:^NSArray *{
        FLDebugCellItem *mainItem = [FLDebugCellItem itemWithTitle:@"切换域名" action:^{
            NSLog(@"切换域名 click");
        }];
        
        FLDebugCellItem *ip6Item = [FLDebugCellItem itemWithTitle:@"ipv6控制台" action:^{
            NSLog(@"ipv6控制台 click");
        }];
        return @[mainItem, ip6Item];
    }];
    
    [self registerWithSection:kFLDebugSection_App block:^NSArray *{
        FLDebugCellItem *versionItem = [FLDebugCellItem itemWithTitle:@"App版本" action:^{
            NSLog(@"1.8.5");
        }];
        
        FLDebugCellItem *bundleIDItem = [FLDebugCellItem itemWithTitle:@"BundleID" action:^{
            NSLog(@"htsc");
        }];
        return @[versionItem, bundleIDItem];
    }];
}

+ (void)registerAfterLaunch
{
    
}

@end
