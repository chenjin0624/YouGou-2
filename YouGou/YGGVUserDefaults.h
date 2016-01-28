//
//  YGGVUserDefaults.h
//  YouGou
//
//  Created by jin on 16/1/25.
//  Copyright © 2016年 merlin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GVUserDefaults.h"

@interface GVUserDefaults (YouGou)

@property(nonatomic,strong)NSString* advertImageUrl;
@property(nonatomic,strong)NSString* advertContentUrl;
@property(nonatomic,strong)NSNumber* advertTime;
@end
