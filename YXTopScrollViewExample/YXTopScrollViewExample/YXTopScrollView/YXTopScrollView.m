//
//  YXTopScrollView.m
//  YXTopScrollViewExample
//
//  Created by shiqin on 2017/2/13.
//  Copyright © 2017年 mifo. All rights reserved.

#import "YXTopScrollView.h"

#define KdownLineCenterY self.bounds.size.height - 1.5

#define KScreenHeight [UIScreen mainScreen].bounds.size.height

#define KScreenWidth [UIScreen mainScreen].bounds.size.width

@interface YXTopScrollView ()

@property (strong, nonatomic) NSMutableArray * btnArr;

@property (nonatomic, weak) UIScrollView * boundScrollV;

@property (nonatomic, weak) UIView * downLine;

@property (nonatomic, weak) UIButton * preBtn;

@end

@implementation YXTopScrollView
static NSArray * items_;

- (NSMutableArray *)btnArr
{
    if (!_btnArr) {
    
        _btnArr = [NSMutableArray array];
    
    }
    
    return _btnArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (frame.size.height < 20) frame.size.height = 20;
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupScrollView];
        
        [self setupButtonsAndline];
        
    }
    
    return self;
}

- (void)setupScrollView
{

    self.backgroundColor = [UIColor whiteColor];
    
    UIScrollView * scrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
    
    scrollV.backgroundColor = [UIColor whiteColor];
    
    scrollV.showsVerticalScrollIndicator = NO;
    
    scrollV.showsHorizontalScrollIndicator = NO;

    scrollV.bounces = NO;
    
    scrollV.alwaysBounceVertical = NO;

    
    [self addSubview:scrollV];
    
    self.boundScrollV = scrollV;
}

- (void)setupButtonsAndline
{
    if (items_.count == 0) return;
    
    CGFloat margin = 20.0f;
    
    CGFloat btnH = self.lineHeight == 0?(self.bounds.size.height-1) : self.lineHeight;
   
    
    for (NSInteger i = 0; i < items_.count; i ++) {
        
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat btnX = 0+10;
        
        if (i != 0) {
            
            UIButton * preBtn = self.btnArr[i-1];
            
            btnX = CGRectGetMaxX(preBtn.frame) + margin;
            
        }
        
        [btn setTitle:items_[i] forState:UIControlStateNormal];
        
        if (self.textNColor) {
            
            [btn setTitleColor:self.textNColor forState:UIControlStateNormal];
            
        }else {
            
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            
        }

        if (self.textHColor) {
            
            [btn setTitleColor:self.textHColor forState:UIControlStateSelected];
            
        }else {
            
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
            
        }
        
        [btn addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font = self.textFont == nil?([UIFont systemFontOfSize:14]): self.textFont;
    
        
        NSMutableDictionary * fontDic = [NSMutableDictionary dictionary];
        
        fontDic[NSFontAttributeName] = self.textFont == nil?([UIFont systemFontOfSize:14]): self.textFont;
        
        CGFloat btnW = [btn.titleLabel.text sizeWithAttributes:fontDic].width + 10;
        
        btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        
        [self.boundScrollV addSubview:btn];
        
        [self.btnArr addObject:btn];
        
    }
    
    UIButton * lastBtn = [self.btnArr lastObject];
    
    self.boundScrollV.contentSize = CGSizeMake(CGRectGetMaxX(lastBtn.frame)+10, self.bounds.size.height);
    
    UIView * downLine = [[UIView alloc]init];
    
    downLine.backgroundColor = self.lineColor == nil?([UIColor orangeColor]):self.lineColor;
    
    UIButton * firstBtn = [self.btnArr firstObject];
    
    firstBtn.selected = YES;
    
    downLine.frame = CGRectMake(firstBtn.frame.origin.x + 5, self.boundScrollV.frame.size.height - 1, firstBtn.frame.size.width-10, 1);

    [self.boundScrollV addSubview:downLine];
    
    self.downLine = downLine;
    
    self.preBtn = firstBtn;
    
    
}

- (void)tagClick:(UIButton *)btn
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(click:) object:btn];
    
    [self performSelector:@selector(click:) withObject:btn afterDelay:0.26];
}

- (void)click:(UIButton *)btn
{
    
    if (btn.selected) return;
    
    self.preBtn.selected = NO;
    
    btn.selected = !btn.selected;
    
    self.preBtn = btn;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        NSInteger index = [self.btnArr indexOfObject:btn];
        
        if (index >= 3 && index != self.btnArr.count - 1) {
            
            [self.boundScrollV setContentOffset:CGPointMake(btn.center.x - self.bounds.size.width * 0.5, 0) animated:YES];
            
        }else if (index < 3) {
            
            [self.boundScrollV setContentOffset:CGPointMake(0, 0) animated:YES];
            
            //控制最后一个按钮的位置
        }else if (index == self.btnArr.count -1 && ((self.boundScrollV.contentOffset.x + KScreenWidth) < self.boundScrollV.contentSize.width)) {
            
            CGFloat offsetX = self.boundScrollV.contentOffset.x + btn.bounds.size.width;
            
            [self.boundScrollV setContentOffset:CGPointMake(offsetX, 0) animated:YES];
            
        }
        
        NSLog(@"x = %f,size = %f,btn.w = %f",self.boundScrollV.contentOffset.x,self.boundScrollV.contentSize.width,btn.frame.size.width);
        
        self.downLine.frame = CGRectMake(btn.frame.origin.x+5, self.boundScrollV.frame.size.height - 1, btn.frame.size.width-10, 3);
        
    }];
    
    if (self.btnClick) {
        
        self.btnClick(btn.titleLabel.text);
        
    }
}

+ (instancetype)initWithOriginY:(CGFloat)y height:(CGFloat)h forItems:(NSArray *)items
{
    items_ = items;
    
    CGRect frame = CGRectMake(0, y,KScreenWidth, h);
    
    YXTopScrollView * yxTopV = [[YXTopScrollView alloc]initWithFrame:frame];
    
    return yxTopV;
    
}


@end
