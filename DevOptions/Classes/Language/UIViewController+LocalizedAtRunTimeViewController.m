//
//  UIViewController+LocalizedAtRunTimeViewController.m
//  DevOptions
//
//  Created by William-José Simard-Touzet on 2018-02-02.
//  Copyright © 2018 Nomade Solutions Mobiles. All rights reserved.
//

#import "UIViewController+LocalizedAtRunTimeViewController.h"
#import "NSBundle+Language.h"
#import <objc/runtime.h>

@implementation UIViewController (LocalizedAtRunTimeViewController)

#pragma mark - Life cycle

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(init);
        SEL swizzledSelector = @selector(runTimeLanguage_init);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

/*-(void)dealloc {
    if (![self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_LANGUAGE_CHANGED object:nil];
    }
}*/

#pragma mark - Method Swizzling

- (void)runTimeLanguage_init {
    if (![self isKindOfClass:NSClassFromString(@"UIInputWindowController")]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLocalizedStrings) name:NOTIFICATION_LANGUAGE_CHANGED object:nil];
    }
    [self runTimeLanguage_init];
}

#pragma mark - Notification

-(void)updateLocalizedStrings {
    if ([self isKindOfClass:[UIAlertController class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    } else if ([self.view isKindOfClass:[UIWebView class]]) {
        return;
    } else if([self.description containsString:@"PKRevealController"]) {
        return;
    } else if ([self isKindOfClass:[UITabBarController class]]) {
        [self viewDidLoad];
        return;
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        return;
    }
    
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self viewDidLoad];
}

#pragma mark - Getters

- (NSString *)pageTag {
    return objc_getAssociatedObject(self, @selector(pageTag));
}

#pragma mark - Setters

- (void)setPageTag:(NSString *)pageTag {
    objc_setAssociatedObject(self, @selector(pageTag), pageTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
