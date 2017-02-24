//
//  TokenModel.h
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/25.
//  Copyright © 2017年 cj. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN
@interface TokenModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSDate *issuedDate;
@property (nonatomic, strong) NSDate *expiredDate;
@property (nonatomic, copy) NSString *token;

@end
NS_ASSUME_NONNULL_END
