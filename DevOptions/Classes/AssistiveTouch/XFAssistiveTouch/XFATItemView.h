//
//  XFATView.h
//  XFAssistiveTouchExample
//
//  Created by 徐亚非 on 2016/9/24.
//  Copyright © 2016年 XuYafei. All rights reserved.
//

#import "XFATPosition.h"

NS_ASSUME_NONNULL_BEGIN

@interface XFATItemView : UIView

+ (instancetype)innerItemWithImage:(UIImage * _Nullable)image title:(NSString* _Nullable)title;
+ (instancetype)assistiveItemWithImage:(UIImage * _Nullable)image;

@property (nonatomic, strong) XFATPosition *position;

@end

NS_ASSUME_NONNULL_END
