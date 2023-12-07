//
//  FLDebugUtils.m
//  Arsenal
//
//  Created by forthonliu on 2023/12/1.
//

#import "FLDebugUtils.h"

@implementation FLDebugUtils

+ (NSString *)sectionNameOfType:(FLDebugSectionType)type
{
    static dispatch_once_t onceToken;
    static NSDictionary *typeDict;
    dispatch_once(&onceToken, ^{
        typeDict = @{
            @(FLDebugSectionType_Recent):@"最近",
            @(FLDebugSectionType_App):@"App",
            @(FLDebugSectionType_Net):@"网络",
            @(FLDebugSectionType_User):@"用户",
            @(FLDebugSectionType_Device):@"设备",
            @(FLDebugSectionType_Business):@"业务",
            @(FLDebugSectionType_Platform):@"平台",
            @(FLDebugSectionType_Data):@"数据",
        };
    });
    return [typeDict objectForKey:@(type)];
}

@end
