//
//  YXTopScrollView.h
//  YXTopScrollViewExample
//
//  Created by shiqin on 2017/2/13.
//  Copyright © 2017年 mifo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXTopScrollView : UIView

@property (strong, nonatomic) NSArray * items;

@property (copy, nonatomic)void(^btnClick)(NSString * title);

/**
 线条高度
 */
@property (nonatomic, assign) NSInteger lineHeight;

/**
 线条颜色
 */
@property (nonatomic, strong) UIColor * lineColor;


/**
 字体大小
 */
@property (strong, nonatomic) UIFont * textFont;
/**
 普通状态下的字体颜色
 */
@property (strong, nonatomic) UIColor * textNColor;

/**
 选中状态下的字体颜色
 */
@property (strong, nonatomic) UIColor * textHColor;

+ (instancetype)initWithOriginY:(CGFloat)y height:(CGFloat)h forItems:(NSArray *)items;


@end
