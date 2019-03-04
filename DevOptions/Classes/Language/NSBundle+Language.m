//
//  NSBundle+Language.m
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2018-01-31.
//  Copyright © 2018 Nomade Solutions Mobiles. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

static const char kBundleKey = 0;

@interface BundleEx : NSBundle
    
@end

@implementation BundleEx
    
- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    NSBundle *bundle = objc_getAssociatedObject(self, &kBundleKey);
    if (bundle) {
        return [bundle localizedStringForKey:key value:value table:tableName];
    }
    else {
        return key;
    }
}
    
@end

@implementation NSBundle (Language)

static NSString *mainStoryBoardName = nil;

+ (void)setLanguage:(NSString *)language {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        object_setClass([NSBundle mainBundle],[BundleEx class]);
    });
    id value = language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil;
    objc_setAssociatedObject([NSBundle mainBundle], &kBundleKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_LANGUAGE_CHANGED object:nil];
    
    if (mainStoryBoardName) {
        [[[UIApplication sharedApplication] keyWindow] setRootViewController:[[UIStoryboard storyboardWithName:mainStoryBoardName bundle:nil] instantiateInitialViewController]];
        
    }
}

+ (void)setMainStoryboardName:(NSString *)name {
    mainStoryBoardName = name;
}

@end
