//
//  NSUserDefaults+reviseSet.h
//  ProductAduit
//
//  Created by james on 2017/3/17.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (reviseSet)
-(void)setNotNull:(id)object forKey:(NSString*)akey;
@end
