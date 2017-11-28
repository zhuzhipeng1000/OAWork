//
//  NSUserDefaults+reviseSet.m
//  ProductAduit
//
//  Created by james on 2017/3/17.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "NSUserDefaults+reviseSet.h"

@implementation NSUserDefaults (reviseSet)
-(void)setNotNull:(id)object forKey:(NSString*)akey{
    if (!object) {
        return;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        object=@"";
    }
    [self setObject:object forKey:akey];

}
@end

