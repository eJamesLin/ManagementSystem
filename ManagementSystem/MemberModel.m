//
//  MemberModel.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{NSStringFromSelector(@selector(identifier)):@"ID",
             NSStringFromSelector(@selector(name)):@"name",
             };
}

@end
