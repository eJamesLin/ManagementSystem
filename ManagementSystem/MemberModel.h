//
//  MemberModel.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/24.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN
@interface MemberModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic) NSInteger identifier;

@end
NS_ASSUME_NONNULL_END
