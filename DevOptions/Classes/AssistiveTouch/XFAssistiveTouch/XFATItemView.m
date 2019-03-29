//
//  XFATItemView.m
//  XFAssistiveTouchExample
//
//  Created by 徐亚非 on 2016/9/24.
//  Copyright © 2016年 XuYafei. All rights reserved.
//

#import "XFATItemView.h"

@interface XFATItemView()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation XFATItemView

+ (instancetype)innerItemWithImage:(UIImage * _Nullable)image title:(NSString* _Nullable)title {
    return [[self alloc] initWithImage:image title:title isInnerItem:YES];
}

+ (instancetype)assistiveItemWithImage:(UIImage * _Nullable)image {
    return [[self alloc] initWithImage:image title:nil isInnerItem:NO];
}

- (instancetype)initWithImage:(UIImage * _Nullable)image title:(NSString* _Nullable)title isInnerItem:(BOOL)isInnerItem  {
    self.imageView = [[UIImageView alloc] init];
    CGRect itemFrame;
    CGFloat imageOffset = 0;
    CGFloat imageSize = 0;
    
    if (isInnerItem) {
        itemFrame = CGRectMake(0, 0, [XFATLayoutAttributes itemWidth], [XFATLayoutAttributes itemHeight]);
        
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _imageView.tintColor = [UIColor whiteColor];
        imageOffset = 5;
        imageSize = [XFATLayoutAttributes itemHeight] - 2 * imageOffset;
        [_imageView setFrame:CGRectMake(imageOffset, imageOffset, imageSize, imageSize)];
    } else {
        itemFrame = CGRectMake(0, 0, [XFATLayoutAttributes itemImageWidth], [XFATLayoutAttributes itemImageWidth]);
        
        imageOffset = 5;
        imageSize = [XFATLayoutAttributes itemImageWidth] - 2 * imageOffset;
        [_imageView setFrame:CGRectMake(imageOffset, imageOffset, imageSize, imageSize)];
    }
    
    self = [super initWithFrame:itemFrame];
    if (self) {
        if (image) [_imageView setImage:image];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_imageView setClipsToBounds:YES];
        [self addSubview:self.imageView];
        
        if (title) {
            UILabel *label = [[UILabel alloc]
                              initWithFrame:CGRectMake(self.imageView.frame.size.width + 2*imageOffset,
                                                       0,
                                                       [XFATLayoutAttributes itemWidth] - imageOffset * 2 - imageSize - [XFATLayoutAttributes itemMargin],
                                                       [XFATLayoutAttributes itemHeight])];
            [label setFont:[UIFont systemFontOfSize:14]];
            [label setNumberOfLines:0];
            [label setTextColor:[UIColor whiteColor]];
            [label setText:title];
            [self addSubview:label];
        }
    }
    
    return self;
}

-(void)setImage:(UIImage*)image {
    [_imageView setImage:image];
}

@end
