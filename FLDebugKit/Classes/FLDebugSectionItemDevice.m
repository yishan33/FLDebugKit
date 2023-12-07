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
    [self registerWithType:FLDebugSectionType_Device block:^NSArray *{
        FLDebugCellItemText *uniqueItem = [FLDebugCellItemText itemWithTitle:@"uniqueID" descriptionText:@" 7A79E966-C01A-4469-AE02-BDC0A91598EA" action:nil];
        
        FLDebugCellItemText *deviceItem = [FLDebugCellItemText itemWithTitle:@"deviceID" descriptionText:@"7A79E966-C01A" action:nil];

        return @[uniqueItem, deviceItem];
    }];
}

+ (void)logDevice
{
    NSLog(@"DeviceID click");
}

@end
