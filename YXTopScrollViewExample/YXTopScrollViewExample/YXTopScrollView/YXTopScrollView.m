//
//  YXTopScrollView.m
//  YXTopScrollViewExample
//
//  Created by shiqin on 2017/2/13.
//  Copyright © 2017年 mifo. All rights reserved.

#import "YXTopScrollView.h"

#define KdownLineCenterY self.bounds.size.height - 1.5

@interface YXTopScrollView ()

@property (strong, nonatomic) NSMutableArray * btnArr;

@property (nonatomic, weak) UIScrollView * boundScrollV;

@property (nonatomic, weak) UIView * downLine;

@property (nonatomic, weak) UIButton * preBtn;

@end

@implementation YXTopScrollView

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
        
        self.autoresizesSubviews = NO;
        
        self.backgroundColor = [UIColor whiteColor];
    
        UIScrollView * scrollV = [[UIScrollView alloc]initWithFrame:self.bounds];
        
        scrollV.backgroundColor = [UIColor whiteColor];
        
        scrollV.showsVerticalScrollIndicator = NO;
        
        scrollV.showsHorizontalScrollIndicator = NO;
        
        scrollV.pagingEnabled = YES;
        
        scrollV.bounces = NO;
        
        [self addSubview:scrollV];
        
        self.boundScrollV = scrollV;
    
    }
    
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = items;
    
    NSLog(@"items = %@",items);
    
    CGFloat margin = 20.0f;
    
    CGFloat btnH = self.lineHeight == 0?(self.bounds.size.height-1) : self.lineHeight;
    
    //CGFloat btnH = self.bounds.size.height-1;
    
    for (NSInteger i = 0; i < items.count; i ++) {
    
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat btnX = 0+10;
        
        if (i != 0) {
        
           UIButton * preBtn = self.btnArr[i-1];
            
           btnX = CGRectGetMaxX(preBtn.frame) + margin;
        
        }
        
        [btn setTitle:items[i] forState:UIControlStateNormal];
        
        if (self.textNColor) {
        
             [btn setTitleColor:self.textNColor forState:UIControlStateNormal];
        
        }else {
        
              [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        }
        
//        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        if (self.textHColor) {
            
            [btn setTitleColor:self.textHColor forState:UIControlStateNormal];
            
        }else {
            
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            
        }
        
//        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.titleLabel.font = self.textFont == nil?([UIFont systemFontOfSize:14]): self.textFont;
        
        //btn.titleLabel.font = [UIFont systemFontOfSize:14];
        
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
    
    //firstBtn.center = CGPointMake(firstBtn.center.x, KdownLineCenterY);
    
    [self.boundScrollV addSubview:downLine];
    
    self.downLine = downLine;
    
    self.preBtn = firstBtn;
    
}

- (void)click:(UIButton *)btn
{
    if (btn.selected)  return;
    
    
    
    self.preBtn.selected = NO;
    
    btn.selected = !btn.selected;
    
    self.preBtn = btn;
 
    [UIView animateWithDuration:0.25 animations:^{
        
        NSInteger index = [self.btnArr indexOfObject:btn];
        
        if (index >= 3 && index != self.btnArr.count -1) {
        
            [self.boundScrollV setContentOffset:CGPointMake(btn.center.x - self.bounds.size.width * 0.5, 0) animated:YES];
        
        }
        
        self.downLine.frame = CGRectMake(btn.frame.origin.x+5, self.boundScrollV.frame.size.height - 1, btn.frame.size.width-10, 3);
        
    }];
    
    if (self.btnClick) {
    
        self.btnClick(btn.titleLabel.text);
    
    }
}


@end
