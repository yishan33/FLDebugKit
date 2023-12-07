//
//  FLDebugDefine.h
//  Arsenal
//
//  Created by forthonliu on 2023/11/27.
//

#ifndef FLDebugDefine_h
#define FLDebugDefine_h

#define UIScreenW [UIScreen mainScreen].bounds.size.width
#define UIScreenH [UIScreen mainScreen].bounds.size.height

typedef NS_ENUM(NSUInteger, FLDebugSectionType) {
    FLDebugSectionType_Recent = 0,
    FLDebugSectionType_App = 1,
    FLDebugSectionType_Net = 2,
    FLDebugSectionType_User = 3,
    FLDebugSectionType_Device = 4,
    FLDebugSectionType_Business = 5,
    FLDebugSectionType_Platform = 6,
    FLDebugSectionType_Data = 7,
};

#endif /* FLDebugDefine_h */
