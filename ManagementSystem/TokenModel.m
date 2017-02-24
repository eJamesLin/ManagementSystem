//
//  TokenModel.m
//  ManagementSystem
//
//  Created by CJ Lin on 2017/2/25.
//  Copyright © 2017年 cj. All rights reserved.
//

#import "TokenModel.h"

@implementation TokenModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{NSStringFromSelector(@selector(token)):@"token",
             NSStringFromSelector(@selector(issuedDate)):@"iat",
             NSStringFromSelector(@selector(expiredDate)):@"exp",
             };
}

+ (NSValueTransformer *)issuedDateJSONTransformer
{
    return [TokenModel NSDateSince1970ReversibleTransformer];
}

+ (NSValueTransformer *)expiredDateJSONTransformer
{
    return [TokenModel NSDateSince1970ReversibleTransformer];
}

+ (NSValueTransformer *)NSDateSince1970ReversibleTransformer
{
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSNumber *val, BOOL *success, NSError **error) {
        return [NSDate dateWithTimeIntervalSince1970:val.doubleValue];
    } reverseBlock:^(NSDate *date, BOOL *success, NSError **error) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [dateFormatter stringFromDate:date];
    }];
}

@end
