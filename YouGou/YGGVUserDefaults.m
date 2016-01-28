//
//  YGGVUserDefaults.m
//  YouGou
//
//  Created by jin on 16/1/25.
//  Copyright © 2016年 merlin. All rights reserved.
//

#import "YGGVUserDefaults.h"

@implementation GVUserDefaults (YouGou)

@dynamic advertImageUrl,advertContentUrl,advertTime;

- (NSString *)transformKey:(NSString *)key {
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] uppercaseString]];
    return [NSString stringWithFormat:@"global%@",key];
}

@end
