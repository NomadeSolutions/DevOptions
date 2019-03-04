//
//  NSBundle+Language.h
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2018-01-31.
//  Copyright © 2018 Nomade Solutions Mobiles. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NOTIFICATION_LANGUAGE_CHANGED @"NOTIFICATION_LANGUAGE_CHANGED"

@interface NSBundle (Language)
+ (void)setLanguage:(NSString *)language;
+ (void)setMainStoryboardName:(NSString *)name;
@end
